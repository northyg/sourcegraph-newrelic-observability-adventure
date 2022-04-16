### Forward logs from GCP -> New Relic

The New Relic Infra guided Install automatically enabled Logs. This was a test to see what other logs would be forwarded if set this up.

To give an idea of where the data is coming from... this would be Logs -> NR

#### Requirements 

* GCP Dataflow API must be enabled
* New Relic Infra agent
* [This might need enabling too - Connect GCP service account to New Relic](https://docs.newrelic.com/docs/infrastructure/google-cloud-platform-integrations/get-started/connect-google-cloud-platform-services-new-relic/)

![image](https://user-images.githubusercontent.com/27694443/163653270-78b63f8b-7b4d-4a71-926c-9d468a878e25.png)

Follow the steps top to bottom from here

https://docs.newrelic.com/docs/logs/forward-logs/google-cloud-platform-log-forwarding

I eventually ran into 403 error when setting up log forwarding from GCP 

Run `gcloud auth login` inside the VM to set up auth (I was surprised I had to do this because I thought I was authed)
Then the next steps worked.


### Additional resousces

https://stackoverflow.com/questions/27275063/gsutil-copy-returning-accessdeniedexception-403-insufficient-permission-from
