# Sample of MicroProfile GraphQL on OpenLiberty

## Test Locally

This is a simple demo of the MP GraphQL capabilities in OpenLiberty.

To run, clone this repository, and then run:
`mvn clean package liberty:run`

Then browse to:
http://localhost:9080/mpGraphQLSample/graphiql.html

Then try a query like:
```
{
    currentConditions(location: "Paris") {
        dayTime
        hasPrecipitation
        temperatureF
        weatherText
        precipitationType
    }
}
```

You should see results similar to (but with random values):
```
{
  "data": {
    "currentConditions": {
      "dayTime": true,
      "hasPrecipitation": true,
      "temperatureF": 8.796591509601903,
      "weatherText": "Overcast",
      "precipitationType": "SNOW"
    }
  }
}
```

## Build Container Image

```
buildah bud -t mp-graphql-sample:latest .
```

# Run Locally

```bash
podman run -p 9080:9080 mp-graphql-sample:latest
```

## Push to OpenShift

```bash
podman login -u $(oc whoami) -p $(oc whoami -t) default-route-openshift-image-registry.apps.{openshift.cluster}/{project}
podman tag mp-graphql-sample:latest default-route-openshift-image-registry.apps.{openshift.cluster}/{project}/mp-graphql-sample:latest
podman push default-route-openshift-image-registry.apps.{openshift.cluster}/{project}/mp-graphql-sample
```

## Build and Deploy in OpenShift

Configure
```bash
oc apply -f openshift.yaml
```

Build
```bash
oc start-build mp-graphql-sample --follow -n {project}
```

## Rollout

```bash
oc rollout restart deployment/mp-graphql-sample -n {project}
```

## Test

Visit https://mp-graphql-sample-{project}.apps.{openshift.cluster}/app/graphiql.html
