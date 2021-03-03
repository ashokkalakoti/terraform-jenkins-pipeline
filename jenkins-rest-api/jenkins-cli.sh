SERVER=http://localhost:8080
USER=admin
APITOKEN=110c6f3658a5ac57fae81e54855dceb65f
CRUMB=$(curl --user $USER:$APITOKEN \
    $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))

echo $CRUMB
#curl --user $USER:$APITOKEN -H "$CRUMB" -d "script=$GROOVYSCRIPT" $SERVER/script
curl -I -X POST http://$USER:$APITOKEN@localhost:8080/job/pipeline-01/build -H "$CRUMB"
