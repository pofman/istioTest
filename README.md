# ISTIO and HELM POC
## Initial setup
1. Install docker
1. Install Kubernetes or use docker integrated instnace
1. Install istio ctl and initialize istio demo profile in the kubernetes cluster
1. Install helm

Configure istio `MeshConfig.OutboundTrafficPolicy.Mode` to be `REGISTRY_ONLY` in order to avoid pods to access any internet endpoint.  
Reference: [Istio - Global Mesh Options](https://istio.io/latest/docs/reference/config/istio.mesh.v1alpha1/#MeshConfig)
## ISTIO ingress gateway logs
`
kubectl logs -n istio-system "$(kubectl get pod -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].metadata.name}')"
`