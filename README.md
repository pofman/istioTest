# ISTIO and HELM POC
## ISTIO ingress gateway logs
`
kubectl logs -n istio-system "$(kubectl get pod -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].metadata.name}')"
`