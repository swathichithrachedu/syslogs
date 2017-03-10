import logging
import logging.handlers
# import socket

LOG_FILENAME = 'logger.log'
logging.basicConfig(filename=LOG_FILENAME,
                    level=logging.DEBUG,
                    )

logging.debug('In Log File...')
# s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
f = open(LOG_FILENAME, 'rt')

try:
    body = f.read()
finally:
    f.close()
print 'FILE:'
print body

def syslog (debug,info,waring,error,critical = "LEVELS"):
     str = "Debug: "+ debug+"Info: "+ info+"Waring: "+ waring+"Error: "+ error+"Critical: " +critical
     return str

my_logger = logging.getLogger('MyLogger')
my_logger.setLevel(logging.DEBUG)

#handler = logging.handlers.SysLogHandler(address = 'C:/Users/swathi/Documents/Logs')
handler = logging.handlers.SysLogHandler(address = ('localhost',514), facility=19)
my_logger.addHandler(handler)

my_logger.debug('this is debug')
my_logger.critical('this is critical')
my_logger.info('this is info')
my_logger.warn('this is critical')


