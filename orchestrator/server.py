from flask import Flask, request, abort
from ipaddress import ip_address

from healer.healingservice import callansible, retry
from db.dblayer.dbservices import TicketDB
from ticketing.jiraservices.jiraservice import createjiraticket,closejiraticket

app = Flask(__name__)

@app.route('/')
def sayhello():
    return "Hello!!"

@app.route('/healing',methods=['POST'])
def healingprocess():
    """
     API to create ticket and healing for service status which is not ok.
     requested parameter must be in json format
     like: {"hostaddress":"127.0.0.1","service":"apache","status":"critical"}
    :return: str
    """
    ticketdb = TicketDB()  #created Ticketdb instance
    try:
        body = request.json
        ip_address(body['hostaddress'])
        hostaddress = body['hostaddress']
        service = body['service']
        status = body['status']
    except Exception:
        return "Requested parameter is not in valid format."

    ticket = createjiraticket(hostaddress,service,status)  # Creating Jira Ticket
    #Inserting created ticket in db
    rows = ticketdb.insertticket(hostaddress,service,status,str(ticket),'open')
    print rows

    if ticket is not None:
        try:
            #Calling Ansible Playbook for healing
            callansible(service,hostaddress)
        except Exception:
            try:
                # Retry after healing failed
                retry(service,hostaddress)
            except Exception:
                try:
                    #Retry after healing failed
                    retry(service, hostaddress)
                except Exception:
                    return "Create L3 Ticket to resolve issue."
    else:
        return "check your internet or Jira credentials."

    return "Healing Process completed successfully."


@app.route('/closingticket',methods=['POST'])
def closeticket():
    """
    API is to close ticket created while healing process.
    required hostaddress, service, and status(service) in
    json format.
    eg. {"hostaddress":"127.0.0.1","service":"apache","status":"critical"}
    :return: str
    """
    try:
        body = request.json
        hostaddress = body['hostaddress']
        service = body['service']
    except Exception:
        return "Requested parameter is not in valid format."

    ticketdb = TicketDB()  # Created TicketDB Instance
    # Retreive Jira ticket object is to be updated to closed.
    ticketobj = ticketdb.retreiveticket(hostaddress,service)
    try:
        # Jira Ticket status updated to closed.
        ticket = closejiraticket(ticketobj.ticketid)
        ticketdb.updateticket(ticketobj.ticketid)
    except Exception:
        return "Check your internet connection"

    return "Ticket closed successfully."


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=9000)
