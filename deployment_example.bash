#!/bin/sh

## POST DEPLOYMENT EXAMPLE

## Doc about Rest API https://docs.newrelic.com/docs/apis/rest-api-v2/get-started/introduction-new-relic-rest-api-v2
## Link to the API explorer https://rpm.newrelic.com/api/explore/api
# First get APM app ID, then use it to post a deployment marker
# Deployments have required fields and optional. You can customize to use env variables and git sha, etc

# REQUIRED:
 # - Application ID
app_id="get_app_id_by_GET_LIST_APPS"
 # - Revision, such as a git SHA
revision_string=$(date)

#OPTIONAL:
 # - Changelog
 # - Description
 # - User posting the deployment
user_string=$(whoami)
 # - Timestamp of the deployment

## variables
changelog_string="sample changelog message"
description_string="sample description message"

curl -X POST 'https://api.newrelic.com/v2/applications/'"$app_id"'/deployments.json' \
     -H 'Api-Key:NRAK-REDACTED-PUT-YOUR-USER_API_KEY_HERE' -i  \
     -H 'Content-Type: application/json' \
     -d \
'{
  "deployment": {
    "revision":"'"$revision_string"'",
    "changelog":"'"$changelog_string"'",
    "description":"'"$description_string"'",
    "user":"'"$user_string"'"
  }
}' 
