from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from ticketmodel import Base,jiraticket

engine = create_engine('mysql+mysqlconnector://root:root@110.110.110.164/cse')

Base.metadata.bind = engine

Session = sessionmaker(bind = engine)

session = Session()

def insertTicket(hostadd,service,status,id,tstatus):
    t = jiraticket(hostadd,service,status,id,tstatus)
    session.add(t)
    session.commit()


def retreiveTicket(hostadd, service):
    tickets = session.query(jiraticket).all()
    for ticket in tickets:
        if ticket.ticketstatus == 'open' and ticket.hostaddress == hostadd and ticket.servicename == service:
            return ticket
    return None

def updateTicket(tid):
    ticket = session.query(jiraticket).filter(jiraticket.ticketid == tid).one()
    ticket.ticketstatus = 'closed'
    ticket.servicestatus = 'ok'
    session.add(ticket)
    session.commit()
