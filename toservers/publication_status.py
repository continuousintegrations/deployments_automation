#!/usr/bin/env python
#Checking status of loading publication progress in ElasticSearch
#Last edited: 13.01.2016r.

from elasticsearch import Elasticsearch

class PPTask:
    def __init__(self, name, task):
        self.name = name
        self.task = task
        self.endDate = "--:--:--"
        self.status = "N/A"

    def dateFinished(self):
        if 'dateFinished' in self.task:
            self.endDate = self.task['dateFinished']
            return self.endDate

    def taskStatus(self):
        self.status = self.task['taskProgress']['lastStage']
        return self.status

def getPublicationStatus():
    es = Elasticsearch(['http://hostname:9200'], http_auth=('user', 'password'))

    res = es.search(index="sequence", doc_type="sequence",
                    body={"query": {"term": {"_id": "PublishingPlan-Production"}}}, version="true", size="1")
    for doc in res['hits']['hits']:
        sequence = doc['_version']
        del res
        process_name = "Production_" + str(sequence)
        res = es.search(index="bss_spublishingprocess_v1", doc_type="SPublishingProcess",
                        body={"query": {"term": {"id.name": process_name}}}, version="true", size="1")

    for proc in res['hits']['hits']:
        print("\nOverall status: %s" % (proc['_source']['meta']['stateData']['last']))
        print("Current sequence value: %s\n" % sequence)
#        for task in proc['_source']['meta']['externalTasks']['tasks']:
#            for task_content in proc['_source']['meta']['externalTasks']['tasks'][task]:
#                taskobj = PPTask(task, task_content)
#                print "Status of %s:" % taskobj.name, taskobj.taskStatus(), "->> Publication date: %s" % taskobj.dateFinished()

if __name__ == '__main__':
    getPublicationStatus()
