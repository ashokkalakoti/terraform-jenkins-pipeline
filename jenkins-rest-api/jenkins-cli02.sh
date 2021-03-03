JKSERVER="http://localhost:8080"
JKUSER="admin"
JKPASSWORD="password@123456"
JKCRUMB=`wget -q --auth-no-challenge --user $JKUSER --password $JKPASSWORD --output-document - 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'`

curl --user $JKUSER:$JKPASSWORD -I -X POST "$JKSERVER/job/pipeline-01/build" -H "$JKcrumb"
