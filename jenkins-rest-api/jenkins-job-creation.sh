PROJECT_NAME=$1
SERVER=http://localhost:8080
USER=admin
APITOKEN=110c6f3658a5ac57fae81e54855dceb62f1452
CRUMB=$(curl --user $USER:$APITOKEN \
    $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))

echo $CRUMB
#curl --user $USER:$APITOKEN -H "$CRUMB" -d "script=$GROOVYSCRIPT" $SERVER/script
#curl -I -X POST http://$USER:$APITOKEN@localhost:8080/job/pipeline-01/build -H "$CRUMB"

curl -X GET http://$USER:$APITOKEN@localhost:8080/job/pipeline-01/config.xml -H "$CRUMB" -o ./jobconfig.xml


curl -s -X POST http://$USER:$APITOKEN@localhost:8080/createItem?name=example-project --data-binary @jobconfig.xml -H "$CRUMB" -H "Content-Type:text/xml"
