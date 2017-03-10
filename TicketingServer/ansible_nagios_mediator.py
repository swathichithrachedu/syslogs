from flask import Flask, request, abort
import os,requests
from time import sleep
from jira import JIRA
import json
import dblayer
import logging
from subprocess import check_output
from flask.views import MethodView
from ErrorHandler.RequestHandler import  geterrorhandlerdetails,rdfile,wrtfile

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello World!"

@app.route('/getscriptpath')
def errorHandler():
    healingKey = request.args.get('key','')
    return errhandlerdata[healingKey][healingKey]

@app.route('/createevent')
def createNagiosEvent():
    os.system("ansible-playbook /home/centos/playbooks/runsamplescript.yml --extra-var 'scriptname=createlogs.sh' --private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem -u ubuntu")
    return "Disk Full"


class errorhandlerView(MethodView):

    def get(self, handler=None, subhandler=None):

        if handler in errhandlerdata.keys():
            return rdfile(filename, handler, subhandler)
        else:
            errorhandler = geterrorhandlerdetails(filename)
            return errorhandler

    def post(self, handler=None, subhandler=None):

        getdata = request.data
        return wrtfile(filename,handler,subhandler, getdata)

app.add_url_rule('/errorhandler/<handler>/<subhandler>', view_func=errorhandlerView.as_view('errorhandler'))
app.add_url_rule('/errorhandler', view_func=errorhandlerView.as_view('geterrorhandler'))



@app.route('/writelog', methods = ['POST'])
def writingLog():
    logging.info('writing log from %s',request.remote_addr)
    logging.info('%s', request.data)
    return "Log Writing done"
        

@app.route('/healing',methods=['POST'])
def callAnsibleModule():
    logging.info("%s - - 'requested for creating jira ticket:'", request.remote_addr)
    body = request.json
    sleep(1)
    options = {
        'server': 'https://atmecs.atlassian.net'}
    jira = JIRA(options, basic_auth=('Guruprasad','GOVIND.dubey'))

    issue_dict = {
        'project': {'key': 'SEAL'},
        'summary': "service "+body['service']+" is in "+body['hoststate']+" state of host : "+body['hostaddress']+".",
        'description': "This issue is created by SEAL, and will be resolved by orchestrator in few minutes.",
        'issuetype': {'name': 'Bug'},
    }
    #jira_ticket = jira.create_issue(fields=issue_dict)
    #print type(jira_ticket)
    #ticket_id = str(jira_ticket)
    #logging.info('Jira ticket created with ticket id %s', ticket_id)
    #logging.info('healing started for %s script deployed to host-address %s', body['service'],body['hostaddress'])
    #print "hello"+str(body['service'])+"hello"+str(body['hoststate'])+"hello"
    ticket = dblayer.retreiveTicket(body['hostaddress'],body['service'])
    print ticket
    if ticket == None:
        jira_ticket = jira.create_issue(fields=issue_dict)
        print type(jira_ticket)
        ticket_id = str(jira_ticket)
        logging.info('Jira ticket created with ticket id %s', ticket_id)
        url = "https://atmecs.atlassian.net/rest/api/2/issue/"+ticket_id+"/assignee"
        item = { "name" : "Guruprasad" }
        params = json.dumps(item).encode('utf8')
        s = requests.session()
        s.auth = ('Guruprasad', 'GOVIND.dubey')
        print "Assignee is assigned for ticket "+ticket_id
        s.headers.update({'Content-Type': 'application/json'})
        resp = s.put(url, data=params, verify=False)
        logging.info('Guruprasad is assigned as assignee for ticket id %s', ticket_id)
        logging.info('healing started for %s script deployed to host-address %s', body['service'],body['hostaddress'])
        dblayer.insertTicket(str(body['hostaddress']),str(body['service']),str(body['hoststate']),ticket_id,'open')
        if body['service'] == 'apache2':
            healing = os.system("ansible -m shell -a 'sudo /etc/init.d/apache2 restart' "+body['hostaddress']+" --private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem -u ubuntu") 
        else:
            os.system("ansible-playbook /home/centos/playbooks/runcommandplaybook/runsamplescript.yml --extra-var 'servicename=disk_space' --private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem -u ubuntu")
    #healing = check_output(["ansible","-m","shell","-a","'sudo","/etc/init.d/apache2","restart'",body['hostaddress'],"--private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem","-u","ubuntu"])
        #logging.info('%s ', healing)
    return "jira ticket created"

@app.route('/updateticket',methods=['POST'])
def updateJiraTicket():
    body = request.json
    options = {
        'server': 'https://atmecstech.atlassian.net'}
    jira = JIRA(options, basic_auth=('govind.dubey@atmecs.com','atmecs@123'))
    ticket = dblayer.retreiveTicket(body['hostaddress'],body['service'])
    issue = jira.issue(ticket.ticketid)
    issue.update(assignee={'name': 'Govind'})
    return "Ticket updated"


@app.route('/closingticket',methods=['POST'])
def closeJiraTicket():
    logging.info("%s - - 'requested for closing jira ticket'", request.remote_addr)
    body = request.json
    ticket = dblayer.retreiveTicket(body['hostaddress'],body['service'])
    if ticket == None:
        print "Ticket closed"
        return "Ticket already closed."
    else:
        id = ticket.ticketid
        url_comment = 'https://atmecs.atlassian.net/rest/api/2/issue/'+str(id)+'/comment'
        url = 'https://atmecs.atlassian.net/rest/api/2/issue/'+str(id)+'/transitions'
        try:
            items = {
                            "update": {
                                "comment": [
                                    {
                                    "add": {
                                        "body": "Comment added when resolving issue"
                                    }
                                }
                                ]
                            },
                            "transition": {
                            "id": "31"
                            }
                    }
            comment = { "body":"This issue has been resolved by SEAL Orchestrator."}
            comment_val = json.dumps(comment).encode('utf8')
            params = json.dumps(items).encode('utf8')
            s = requests.session()
            s.auth = ('Guruprasad', 'GOVIND.dubey')
            print "Getting Request"
            s.headers.update({'Content-Type': 'application/json'})
            commentresp = s.post(url_comment, data=comment_val, verify=False)
            fresp = s.post(url, data=params, verify=False)
            print fresp.content
            logging.info('%s ticket closed', id)
            dblayer.updateTicket(tid=id)

        except Exception as e:
            return "Ooops! :(\nCheck your internet connection!!"

    return "Ticket closed : Check ticket"


if __name__ == '__main__':
    logging.basicConfig(filename='/home/centos/pythonserver.log', filemode='a+', format='%(asctime)s : %(message)s', level=logging.INFO,
                        datefmt='%m/%d/%Y %I:%M:%S %p')
    logging.info('Start: server got started,initializing')
    global filename, errhandlerdata
    filename = os.path.join(os.path.dirname(__file__), 'RepoNagiosErrorHandler/NagiosErrorHandler.json')
    errhandlerdata = json.loads(geterrorhandlerdetails(filename))
    logging.info('Finish: Initializing data')
    app.run(host= '0.0.0.0',port = 9000,debug = True)
    logging.info('ShutDown: Server getting down')

