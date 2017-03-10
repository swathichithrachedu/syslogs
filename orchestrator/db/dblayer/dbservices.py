from db.dblayer.DBModels import ScriptModel, TicketModel
from db.utils.dbutils import session


class TicketDB():
    """
    TicketDB class defined for using CRUD operation of Ticket created
    while healing process of Monitoring agents.
    """

    def __init__(self):
        pass

    def insertticket(self, hostadd,  # type: str
                     service,  # type: str
                     status,  # type: str
                     id,  # type: str
                     tstatus  # type: str
                     ):
        # type: () -> int

        """
        Method is defined to insert the new ticket created with following parameter :
        :param hostadd: host ip
        :param service: service of host which status got changed
        :param status: service status
        :param id: ticket Id which is created as issue
        :param tstatus: status like [open,to do, closed]
        :return: no of rows updated
        """

        t = TicketModel(hostadd, service, status, id, tstatus)
        x = session.add(t)
        session.commit()
        return x

    def retreiveticket(self, hostadd,  # type: str
                       service  # type: str
                       ):
        # type: () -> TicketModel

        """
        Method is defined to retreive the ticket for same service and host which is not yet closed.
        :param hostadd: host ip
        :param service: service of host which status was changed
        :return: ticketmodel object
        """

        tickets = session.query(TicketModel).all()
        for ticket in tickets:
            if ticket.ticketstatus == 'open' and ticket.hostaddress == hostadd and ticket.servicename == service:
                return ticket
        return None

    def updateticket(self, tid):
        # type: (str) -> int

        """
        Method is defined to update the ticket status to closed, and service status to ok.
        :param tid: ticket id which have to update.
        :return: no of rows updated
        """

        ticket = session.query(TicketModel).filter(TicketModel.ticketid == tid).one()
        ticket.ticketstatus = 'closed'
        ticket.servicestatus = 'ok'
        x = session.add(ticket)
        session.commit()
        return x


class ScriptDB():
    def __init__(self):
        pass
