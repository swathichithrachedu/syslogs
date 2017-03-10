from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine, Column, String

engine = create_engine('mysql+mysqlconnector://root:root@110.110.110.164/cse')

Base = declarative_base()

class jiraticket(Base):
    __tablename__ = 'jira_ticket'
    hostaddress = Column(String(20),primary_key=True)
    servicename = Column(String(20),primary_key=True)
    servicestatus = Column(String(20))
    ticketid = Column(String(10),primary_key=True)
    ticketstatus = Column(String(10))

    def __init__(self,hostadd,service,status,id,tstatus):
        self.hostaddress = hostadd
        self.servicename = service
        self.servicestatus = status
        self.ticketid = id
        self.ticketstatus = tstatus

Base.metadata.create_all(engine)


