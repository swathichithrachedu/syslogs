from sqlalchemy import Column, String, Integer
from sqlalchemy.dialects.mysql import BLOB
from db.utils.dbutils import Base, engine


class TicketModel(Base):
    __tablename__ = 'tickets'
    hostaddress = Column(String(20))
    servicename = Column(String(20))
    servicestatus = Column(String(20))
    ticketid = Column(String(10), primary_key=True)
    ticketstatus = Column(String(10))

    def __init__(self, hostadd, service, status, id, tstatus):
        self.hostaddress = hostadd
        self.servicename = service
        self.servicestatus = status
        self.ticketid = id
        self.ticketstatus = tstatus


class ScriptModel(Base):
    __tablename__ = 'scripts'
    scriptid = Column(Integer, primary_key=True)
    scriptname = Column(String(20))
    script = Column(BLOB)

    def __init__(self, id, name, script):
        self.scriptid = id
        self.scriptname = name
        self.script = script


Base.metadata.create_all(engine)
