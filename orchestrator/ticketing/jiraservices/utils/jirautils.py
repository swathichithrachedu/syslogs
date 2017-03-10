import os
import json

from jira import JIRA

with open(os.path.dirname(os.path.dirname(os.path.abspath('')))+'/seal/orchestrator/configurations/config.json') as configfile:
    data = json.load(configfile)


jira_url = data['Ticketing']['jira_url']
jira_username = data['Ticketing']['jira_username']
jira_password = data['Ticketing']['jira_password']

def getjiraobject():

    # type: () -> JIRA
    """
    Method is defined to create a jira object and perform
    all jira ticket operation using that.
    :return: jira Object
    """

    options = {
            'server': jira_url}
    jira = JIRA(options, basic_auth=(jira_username,jira_password))
    return jira
