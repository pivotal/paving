## HTTP2 load balancer for GCP

This override will enable the HTTP2 protocol for the backend services used in the GCP load
balancer. **DO NOT USE** Unless you've enabled the HTTP/2 feature..

We see that some clients (e.g. `curl`) will automatically upgrade to an HTTP2 connection.
**Be aware** The gorouter explicitly blocks any HTTP2 request. Outbound HTTP2 requests from the load balancer will fail when forwarding to gorouter.

Here is an issue to track the HTTP2 feature, and to see when gorouter will be ready for HTTP2: https://github.com/cloudfoundry/routing-release/issues/200

We're anticipating this feature to be available in TAS version 2.12.

To use, please copy all the contents in the `http2-lb-gcp/terraform` directory to your current terraform templates.
