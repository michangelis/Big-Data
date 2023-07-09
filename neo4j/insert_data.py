from py2neo import Graph
import csv


if __name__ == '__main__':
    graph = Graph("bolt://localhost:7687", auth=("neo4j", "007clocky"))


    # Load moc_actions.tsv
    with open("mooc_actions.tsv", 'r') as data_file:
        csv_reader = csv.reader(data_file, delimiter='\t')
        header = next(csv_reader)  # skip the header
        for row in csv_reader:
            query = """
            MERGE (u:User {USERID: $USERID})
            MERGE (t:Target {TARGETID: $TARGETID})
            MERGE (u)-[a:Action {ACTIONID: $ACTIONID, TIMESTAMP: $TIMESTAMP}]->(t)
            """
            graph.run(query, USERID=row[2], TARGETID=row[1], ACTIONID=row[0], TIMESTAMP=row[3])

    # Load mooc_action_labels.tsv
    with open("mooc_action_labels.tsv", 'r') as data_file:
        csv_reader = csv.reader(data_file, delimiter='\t')
        header = next(csv_reader)  # skip the header
        for row in csv_reader:
            query = """
            MATCH ()-[a:Action {ACTIONID: $ACTIONID}]->()
            SET a.LABEL = $LABEL
            """
            graph.run(query, ACTIONID=row[0], LABEL=row[1])

    # Load mooc_action_features.tsv
    with open("mooc_action_features.tsv", 'r') as data_file:
        csv_reader = csv.reader(data_file, delimiter='\t')
        header = next(csv_reader)  # skip the header
        for row in csv_reader:
            query = """
            MATCH ()-[a:Action {ACTIONID: $ACTIONID}]->()
            SET a.FEATURE0 = $FEATURE0, a.FEATURE1 = $FEATURE1, a.FEATURE2 = $FEATURE2, a.FEATURE3 = $FEATURE3
            """
            graph.run(query, ACTIONID=row[0], FEATURE0=row[1], FEATURE1=row[2], FEATURE2=row[3], FEATURE3=row[4])


