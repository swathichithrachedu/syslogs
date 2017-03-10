import json
import os


def geterrorhandlerdetails(filename):
    with open(filename, 'r') as errorhandler:
        jsonload = json.load(errorhandler)
        val = filename.split("/")[:-1]
        mainfilewithpath = dict()

        for key,value in jsonload.items():
            subdirfile = dict()
            for filekey, filevalue in value.items():
                subdirfile[filekey] = "/".join(val) + "/" + key + "/"+filevalue
            mainfilewithpath[key] = subdirfile
        return json.dumps(mainfilewithpath)


def seterrorhandlerdetails(filename, handlerkey, subhandlerkey, flag):

    loadedjson = None
    keymodification = "".join(subhandlerkey.split('.')[:-1]) if len(subhandlerkey.split('.')) == 2 else subhandlerkey

    with open(filename,'r+') as errorhandler:
        loadedjson = json.load(errorhandler)

        if flag == 1:
            allfile = loadedjson[handlerkey]
            allfile[keymodification] = subhandlerkey

            loadedjson[handlerkey] = allfile
        elif flag == 2:
            newfiledict = dict()
            newfiledict[keymodification] = subhandlerkey
            loadedjson[handlerkey] = newfiledict

    with open(filename,'w+') as writerrhandler:
        json.dump(loadedjson, writerrhandler, indent=4, skipkeys=True, sort_keys=True)


def rdfile(filename, handlerkey, subhandlerkey):
    errhandlefile = None

    with open(filename,'r') as readfile:
        loadedjson = json.load(readfile)
        val = filename.split("/")[:-1]
        errhandlefile = "/".join(val) + '/' + handlerkey + '/' + loadedjson[handlerkey][subhandlerkey]

    with open(errhandlefile,'r') as errhandle:
             return str(errhandle.read())


def wrtfile(filename, handlerkey, subhandlerkey, handlercontent):

    errhandlefile = None
    val = filename.split("/")[:-1]
    flag = -1   # 0 for existing script change ,1 for adding new script to the existing folder,2 new dir and new file

    with open(filename,'r') as readfile:
        loadedjson = json.load(readfile)

        if handlerkey in loadedjson:

            if subhandlerkey in loadedjson[handlerkey]:

                errhandlefile = "/".join(val) + '/' + handlerkey + '/' + loadedjson[handlerkey][subhandlerkey]

                with open(errhandlefile, 'w') as errhandle:
                    errhandle.write(handlercontent)
                    flag = 0

            else:

                newfilepath = "/".join(val) + "/" + handlerkey + "/" + subhandlerkey

                with open(newfilepath,'w+') as newfilecontent:
                    newfilecontent.write(handlercontent)
                    flag = 1
                    seterrorhandlerdetails(filename, handlerkey, subhandlerkey, flag)
        else:

            newdirname = "/".join(val) + "/" + handlerkey
            os.makedirs(newdirname)
            with open(newdirname+ "/" + subhandlerkey,'w+') as newdirfile:
                newdirfile.write(handlercontent)
                flag = 2
                seterrorhandlerdetails(filename, handlerkey, subhandlerkey, flag)

    return "Existing Script Content Updated" if flag == 0 else ("New Script Added to Existing Directory" if flag == 1
                                                                else "New Directory and New file Added")



if __name__ == "__main__":
    filename = '/home/hpnova/gitclone/seal_local/RepoNagiosErrorHandler/NagiosErrorHandler.json'
    print seterrorhandlerdetails(filename,'dinan', 'govind.sh', 2)
