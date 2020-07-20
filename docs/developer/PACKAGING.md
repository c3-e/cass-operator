# Packaging for Operator Hub

Shamelessly pulled from the [documentation](https://sdk.operatorframework.io/docs/olm-integration/generating-a-csv/).

Make sure you are in the `operator` directory before running these commands.

## Known Issues

Currently the OperatorHub.io website generates a slightly different version of the `spec.customresourcedefinitions.owned[]` field compared to `operator-sdk` (v0.17.0). The one generated by the SDK is missing some information.

Consider validating your generated CSV files with the [Package Builder](https://operatorhub.io/packages).

### Unsupported Resource Types
1. Namespace
2. Secret
3. ValidatingWebhookConfiguration
4. Service

## Create CSV (no previous version)

Generate Cluster Service Version (CSV). This should be done once per project. Everything else should be an UPGRADE.

```bash
operator-sdk generate csv --make-manifests=false --csv-version a.b.c
```

**Example:**

```bash
operator-sdk generate csv --operator-name cass-operator --csv-version 1.0.0 --make-manifests=false
```

Update files under `operator/deploy/olm-catalog/cass-operator/a.b.c`

## Update CSV

_Useful when adding a CRD to a project_

Run the generate command again and new CRDs will be added to the CSV. Use this command on a CSV that has NOT been released and YAML files in the deploy directory have changed.

```bash
operator-sdk generate csv --make-manifests=false --csv-version a.b.c
```

**Example:**

```bash
operator-sdk generate csv --operator-name cass-operator --csv-version 1.0.0 --make-manifests=false
```

## Upgrade CSV

Run the generate command and specify the old version to base on. This is for a new version of our operator that needs to be deployed.

Once it completes make sure to copy the _current_ CRD in to the newly created directory under `operator/deploy/olm-catalogs/cass-operator/cass-operator.v$VERSION/

```bash
operator-sdk generate csv --operator-name cass-operator --make-manifests=false --csv-version d.e.f --from-version a.b.c
```

Note, not everything will be copied from the previous version. Check the following keys:

* `alm-examples` - Used as an example in the OpenShift and Operator Hub UIs
* `resources` - Defines all the resource types that this operator may managed
* `specDescriptors` - Description of all fields in the CRD with UI hints. See https://github.com/openshift/console/tree/release-4.3/frontend/packages/operator-lifecycle-manager/src/components/descriptors for a complete list.
* `runAsUser` & `runAsGroup` - Make sure these are unspecified. In OpenShift environments these are set by the platform.

**Example:**

```bash
operator-sdk generate csv --operator-name cass-operator --csv-version 1.1.0 --make-manifests=false --from-version 1.0.0
```

## Defining Descriptors

https://github.com/openshift/console/blob/master/frontend/packages/operator-lifecycle-manager/src/components/descriptors/reference/reference.md
https://github.com/openshift/console/tree/release-4.3/frontend/packages/operator-lifecycle-manager/src/components/descriptors

## Validating Operator SDK Manifests

Open `operator.osdk-scorecard.yaml` and validate there is an

```bash
operator-sdk scorecard
```

## Common Issues
* `runAsUser` set to `999` in the deployment - OpenShift prefers to set a randomly assigned user at container start time. If this field is not left empty the user field must be set extremely high. 999 is too low.
* Prerequisite custom resources have not been included in the appropriate section of the operator metadata testing page
* The package has not been marked as published in the Red Hat repo.