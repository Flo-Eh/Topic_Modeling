# MLOps - Topic Modeling

## About the project 
Topic Modeling:

As digitally available textual repositories are becoming larger and larger, traditional close reading methods are no longer sufficient to analyse mass of digital data. Topic Modeling is a computational, statistical method to discover patterns and topics in large collections of text.

## Data:

This open access collection (https://zenodo.org/record/4596345#.Yk2flG5Bz0o ) includes the digitized front pages of 10 Italian language newspapers published in California, Connecticut, Pennsylvania, Vermont, and West Virginia. It totals 8,653 issues and contains 21,454,455 words. The titles are: L’Italia, Cronaca sovversiva, La libera parola, The patriot, La ragione, La rassegna, La sentinella del West Virginia, L’Indipendente, La Sentinella, and and La Tribuna del Connecticut. The material was collected from Chronicling America, an Internet-based, searchable database of U.S. newspapers published in the United States from 1789 to 1963 made available by the Library of Congress. The corpus features mainstream (prominenti), anarchic (sovversivi), and independent newspapers thus providing a very nuanced picture of the Italian immigrant community in the United States at the turn of the twentieth century.

## API goal:

Our API aims at enabling users to update a pre-trained model that has been trained with the collection described above, and to monitor the evolution of metrics over time. We have chosen two metrics to do so: coherence and perplexity. The coherence score measures the statistical accuracy of the model, whereas perplexity helps determining whether the model is too specific or too generic for a corpus of text. If thresholds are reached, the API alerts users and offers a route to retrain the model in order to assess again the number of topics to be used, as a preparation step before creating a new model.

## Deploy project 
```
docker-compose up
```

Start Streamlit:

```
streamlit run streamlit/Topic_Modeling.py
```
### Using the API

go to http://localhost:8000/docs
  
## Metrics and performance requirements


## Implementation scheme

1. Data Ingestion:
• Implement the data ingestion script (1_data_ingestion.py) as described earlier.
• Store the processed data in the database management system (MySQL) instead of saving it to a CSV file.
• Ensure the database connection and table creation are handled appropriately within the script.
• Use of an ORM (Object-Relational Mapping) library like SQLAlchemy to interact with the database.
2. Pre-processing:
• Implement the pre-processing script (2_pre_processing.py) to perform text pre-processing as described earlier.
• Retrieve the data from the database management system instead of loading it from a CSV file.
• Update the script to store the pre-processed data back into the database, associating it with the respective records?
3. Model Training:
• Implement the model training script (3_model_training.py) to train the LDA model as described earlier.
• Modify the script to retrieve the pre-processed data from the database.
• Store the trained LDA model in the MLflow tracking server using the MLflow Python API, providing the necessary metadata such as the experiment name and run parameters.
4. KPI Calculation:
• Implement the KPI calculation script (4_kpi.py) to calculate the coherence value using the trained LDA model as described earlier.
• Retrieve the trained LDA model from the MLflow tracking server using the MLflow Python API?
• Perform the coherence calculation and print the result.
5. Airflow Integration:
• Set up an Airflow DAG (Directed Acyclic Graph) to orchestrate the project workflow for model retraining if metrics are not ok.
• Define the tasks corresponding to each script (data ingestion, pre-processing, model retraining, and KPI calculation) as separate operators within the DAG.
• Define the dependencies between the tasks to ensure the proper order of execution: if KPI not okay then relaunch from data ingestion to retraining.
6. Database Management System Integration:
• Establish the connection to the selected database management system in the project scripts.
• Update the scripts to interact with the database for data ingestion, storage, and retrieval operations.
7. API Development with FastAPI:
• Create a new Python script to define the FastAPI application.
• Use FastAPI to define the API endpoints that will interact with the trained model.
• Implement an endpoint to accept input text data from the user and return the corresponding topic predictions using the trained LDA model.
• Ensure the API endpoints perform the necessary data preprocessing and pass the preprocessed data to the LDA model for prediction.
8. Dockerization:
• Dockerize the entire project, including all the necessary dependencies and scripts, to create a portable and reproducible container image.
• Write a Dockerfile to define the container environment and instructions for building the image.
• Consider using a lightweight base image and installing the required dependencies (e.g., Python, MySQL database drivers) within the Dockerfile.
• Include the necessary scripts, such as the FastAPI application script and other project scripts, in the Docker image.
• Docker Compose everything. 
9. Continuous Integration and Deployment (CI/CD):
• Set up a CI/CD pipeline to automate the building, testing, and deployment processes with Github actions.


<img width="1256" alt="Capture d’écran 2023-06-29 175323" src="https://github.com/MariellaCC/MLOps-TopicModeling/assets/83060092/28010b38-84b1-4d9d-936b-230a4d363053">


## Implementation Logical Worflow: Technical Architecture 

![MLOps Topic Modeling Diagram](https://github.com/MariellaCC/MLOps-TopicModeling/assets/83060092/59550731-6359-4a68-a777-c4fbe51a8e2e)

## AirFlow: Graph View

<img width="603" alt="airflow graph view" src="https://github.com/MariellaCC/MLOps-TopicModeling/assets/83060092/a5607683-281b-463f-b132-2369d5d146e5">

## AirFlow: Tree View

As an example: metrics are bad starting from June 29, 17:56 which starts the retraining process.

<img width="1254" alt="airflow tree view" src="https://github.com/MariellaCC/MLOps-TopicModeling/assets/83060092/8d60ebb5-e62b-4769-8afd-42b20e5f9147">


## References

1. Viola, Lorella and de Crouy-Chanel, Mariella. 2020. Topic Modelling with Gensim. A workflow for the Humanities (v. 1.0.0). University of Luxembourg. https://github.com/DHARPA-Project/TopicModelling-
