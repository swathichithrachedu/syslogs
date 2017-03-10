import os
import json
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

"""
This file is defined to return Session, Engine, and Base Object.
"""

with open(os.path.dirname(os.path.dirname(os.path.abspath('')))+'/seal/orchestrator/configurations/config.json') as configfile:
    data = json.load(configfile)

engine = create_engine(data['Database']['sql_connector'])
Base = declarative_base()
Base.metadata.bind = engine
Session = sessionmaker(bind = engine)
session = Session()
