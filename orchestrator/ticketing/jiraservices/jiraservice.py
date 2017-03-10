from ticketing.jiraservices.utils.jirautils import getjiraobject
from jira import JIRAError
from db.dblayer.dbservices import TicketDB


def createjiraticket(hostaddress,service,servicestate):

    # type: (str,str,str) -> JIRA
    """
    Method is defined to create JIRA Ticket,
    for given service which state changed to given servicestate
    for given hostaddress.
    :param hostaddress: Monitoring agent host IP
    :param service: Monitoring agent service
    :param servicestate: Current state of service
    :return: Jira Object
    """
    jira = getjiraobject()
    issue_dict = {
        'project': {'key': 'SEAL'},
        'summary': "service "+service+" is in "+servicestate+" state of host : "+hostaddress+".",
        'description': "This issue will be resolved by orchestrator in few minutes.",
        'issuetype': {'name': 'Bug'},
    }
    try:
        jira_ticket = jira.create_issue(fields=issue_dict)
        return jira_ticket
    except JIRAError as e:
        return None


def closejiraticket(ticketid):

    # type: (str) -> JIRA
    """
    Method to close the jira ticket created with given
    ticket id.
    :param ticketid: Jira ticket id
    :return: str
    """

    jira = getjiraobject()
    try:
        issue = jira.issue(ticketid)
    except JIRAError as e:
        return "IssueNotFound"
    transition = jira.transitions(issue)
    for t in transition:
        if t['name'] == 'Done':
            try:
                jira.transition_issue(ticketid,t['id'])
                comment = jira.add_comment(ticketid, 'Problem Resolved')
                return "TicketClosed"
            except JIRAError as e:
                return "TicketCan'tBeClosed"


if __name__ == '__main__':
    #j = createjiraticket('localhost','unknown','null')
    tdb = TicketDB()
    #x = tdb.insertticket('localhost','unknown','null',str(j),'open')

    t=tdb.retreiveticket('localhost','unknown')
    closejiraticket(t.ticketid)