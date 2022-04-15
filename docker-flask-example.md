#### Docker Flask Example + Modifications

In my local [environment I modified this example project](https://github.com/northyg/docker-flask-example) by adding some to generate traffic

Running steps to remember:

Initialize the DB with this `./run flask db reset --with-testdb`
Run with this to start python agent too `NEW_RELIC_CONFIG_FILE=newrelic.ini newrelic-admin run-program python3 app.py`
