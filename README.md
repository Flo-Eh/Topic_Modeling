# Topic Modelling with Python - A workflow for the Humanities

As digitally available textual repositories are becoming larger and larger, the relevance of distant reading for the humanities has grown exponentially. As a direct consequence, humanities scholars are more and more confronted with the challenge of having to apply quantitative approaches in their research, for traditional close reading methods are no longer suitable for the analysis of such unprecedented mass of digital data. One such quantitative approach is Topic Modelling (TM), a computational, statistical method to discover patterns and topics in large collections of unstructured text. While there are many TM programs and tutorials available, what appears to be still missing is a description of a generalizable TM workflow for the humanities. With this repository, the **DHARPA Project** aims to offer a step-by-step guidance for a versatile method that could be applied transversely across different datasets. Specifically, it provides a way to enrich the distant reading technique of TM with the qualitative information necessary for contextualising the TM results and opening up avenues for interpretation. This workflow is partially based on [Viola and Verheul](https://academic.oup.com/dsh/advance-article/doi/10.1093/llc/fqz068/5601610) (2019).

## Table of contents

1. [The DHARPA Project](#the-dharpa-project)
2. [Topic Modelling](#topic-modelling)

   2.1 [What is a topic?](#what-is-a-topic)
  
3. [Getting started](#getting-started)
4. [Installation](#installation)
5. [Preparing the data (1 of 2)](#preparing-the-data-1-of-2)
6. [Preparing the data (2 of 2)](#preparing-the-data-2-of-2)
7. [Determining the number of topics](#determining-the-number-of-topics)
8. [Running topic modelling](#running-topic-modelling)
9. [Categorising the topics](#categorising-the-topics)
10. [Historicise the topics](#historicise-the-topics)
11. [Visualise the topics](#visualise-the-topics)
12. [Remarks](#remarks)
13. [License](#license)
14. [Links](#links)
15. [References](#references)
16. [The team](#the-team)
17. [How to cite](#how-to-cite)

## The DHARPA Project
While the ‘digital humanities moment’ has yielded great accomplishments and enthusiastic interdisciplinary cooperations across the humanities and between the humanities and the sciences, concerns have been raised about the little transparency in digital practices as well as the difficulty of replicating studies precisely due to the lack of data access, unclear methodological processes, or standardised practices (Faull et al 2016; Jakacki et al 2016, 2015; O’ Sullivan 2019). Such concerns have for instance led scholars to claim that digital humanities is still in “search of a methodology” (Dobson 2019) and the metaphor of the 'black box' has started to be used (Smith 2014) to describe the lost of human agency in the digital reseach process. Historical inquiry itself has in some ways been like a “Mechanical Turk,” with the decisions and interventions made by the researcher hidden from view and only the well-oiled and seemingly autonomous product on display. The DHARPA Project (Digital History Advanced Research Projects Accelerator) aims to reverse this trend. We want to encourage historians and digital humanities scholars to lift the lid, to show how the application of their expertise works in tandem with technology to produce knowledge, how even digitally enabled research is not a product but a process, reliant on the critical engagement of the scholar. We, the DHARPA team, are building more than just a bigger toolbox. We are building a software to self-reflexively examine the interaction of technology and humanities practice.   

## Topic Modelling
Before talking about topic modelling and how it works, it is worth spending a few words on what is intended by *topic*. This will also help to clarify how the topic modelling algorithm works and how we should treat the output.

## What is a topic?
A topic is understood as a set of terms that occur together in a statistically significant way to form a cluster of words. According to this logic, a text can be understood as the combination of such clusters of words, where each cluster is made of words mathematically likely to appear together (Steyvers and Griffiths 2007). The model assumes that a corpus has a fixed number of founding topics and that these topics compose each document of the corpus to varying degrees (Lee 2019). Using contextual information, topic models are able to distinguish between words used with multiple meanings; this ultimately means that the words are also clustered according to similar uses. What happens in practice is that TM runs statistical calculations multiple times until it determines the most likely distribution of words into clusters, i.e. into topics. The procedure guarantees impartial results in terms of which words will appear in each topic, as the topics emerge from the algorithm’s identification of patterns and trends in the texts, rather than the potential interpretation of the semantic meaning of the words in each document. In this sense, there is no intervention from the researcher. This analytical tool works the best with large collections of unstructured text (i.e., without any machine-readable annotations) and when the main purpose is to obtain a general overview of the topics discussed in the corpus. As long as it is unstructured, the corpus can be just about anything (e.g., emails, newspapers' headlines, newspapers' articles). For this, TM is an excellent distant reading tool that may be used as a data exploration technique, for instance to quickly categorise documents within a collection without having to read them all. A practical example of its use may be libraries that need to label digital collections for archiving purposes. Its potential, however, is most fully reached when working in tandem with close reading.

## Getting started
There are many variations of the TM algorithm and numerous programs and techniques to implement them. The rationale behind all of them, however, is the same: using statistical modelling to discover topics in a textual collection. Among these very many techniques, Latent Dirichlet Allocation (LDA - [Blei, Ng and Jordan 2003](http://www.jmlr.org/papers/volume3/blei03a/blei03a.pdf)) is perhaps the most widely used. In this workflow, we use Gensim, a Python library for topic modelling, document indexing and similarity retrieval which also implements LDA. This software depends on the Python packages NumPy and Scipy, which must be installed prior to installing Gensim. Although in principle scholars are free to use whichever TM program they feel more comfortable with, a major advantage of using Gensim is its memory efficiency, significantly higher than other software (e.g., Mallet) which have often issues handling big data. More information about Gensim, including the offical documentation, can be found [here](https://pypi.org/project/gensim/).

## Installation
Please install Python 3.6 or higher to run the notebook. The notebook makes use
of the dependencies found in `requirements.txt`. Install the dependencies with 
pip by running the following line of code in your terminal.

```sh
pip install -r requirements.txt
```
## Preparing the data (1 of 2)
This step is concerned with tokenization, lowercasing, stemming, lemmatization, removing stopwords and words with less than three characters, removing noise (e.g., numbers, punctuation marks, special characters). In principle, it is optional as the train-topic command will work on whichever version of the dataset is used. In reality, pre-processing the data is key to the analysis for several reasons. First and foremost, it will likely make the TM results more reliable and more interpretable. For instance, running TM on languages that are rich in articles, pronouns, prepositions, etc., will almost certainly result in poorly interpretable topics. Second, pre-processing the data will remove most OCR mistakes which are always present in digital textual collections. This is especially true for corpora such as historical datasets, repositories of underdocumented languages, digitised archives from handwritten texts. Third, it will reduce the size f your collections thus decreasing the required processing power. Fourth, it can be considered as a first data exploration which will allow the researcher to look more closely at their data. 
Deciding which of the pre-processing operations should be performed depends on many factors such as the language of the dataset, the type of data, the individual research questions. It is therefore paramount that this step is tackled **critically** by the researcher as each one of their interventions will have consequences on how the TM algorithm will process the data and therefore on the results. Here's a short explanation of each operation:
- **Tokenization**: Split the text into sentences and the sentences into words. In other words, this operation establishes the word boundaries (i.e., tokens) which is very helpful for finding patterns. It is also the typical step prior to stemming and lemmatization; 
- **Lowercasing**: Lowercase the words. This operation is a double-edged sword. It can be effective at yielding potentially better results in the case of relatively small datasets or datatsets with a high percentage of OCR mistakes. For instance, if lowercasing is not performed, the algorithm will treat *USA*, *Usa*, *usa*, *UsA*, *uSA*, etc. as distinct tokens, even though they all refer to the same entity. On the other hand, if the dataset does not contain such OCR mistakes, then it may become difficult to distinguish between homonyms which will make interpreting the topics much harder;
- **Stemming/Lemmatization**: Reduce inflection in words (e.g. states --> state). Although similar, stemming should not be confused with lemmatization. While the latter reduces the inflected word to the actual root form (e.g., better --> good), the former outputs a canonical form of the original word (e.g., past and future tense --> present tense), and not the grammatical root. Performing or not either of these operations is very much dependant on the dataset's language as in terms of TM, they may not affect the output *per se*;
- **Removing stopwords and words with less than three characters**: Remove low information words. These are typically words such as articles, pronouns, prepositions, conjunctions, etc. which are not semantically salient. There are numerous stopword lists available for many, though not all, languages which can be easily adapted to the individual researcher's needs. Removing words with less than three characters will additionally remove many OCR mistakes. Both these operations have the dual advantage of yielding more reliable results while reducing the size of the dataset, thus in turn reducing the required processing power. This step can therefore hardly be considered optional in TM;
- **Noise removal**: Remove elements such as punctuation marks, special characters, numbers, html formatting, etc. This operation is again concerned with removing elements that may not be relevant to the text analysis and that can in fact interfere with it. Depending on the dataset and research question, this operation can be essential.

These operations will need to be quantitatively and qualitatively tested each time before deciding which ones to actually perform. This is of course true not just for TM, but in general for all NLP tasks. It is important to remember that each one of these steps is an additional layer of text manipualation and has direct consequences on the data and therefore on the results. It is critical that researchers assess carefully to what degree they want to intervene on the data. For this reason, this part of the digital analysis should not be considered as separate from the analysis of the results. On the contrary, it is an integral part of the entire digital research process as it is key to understanding the data and ultimately, to arriving at a more accurate interpretation of the results.

## Preparing the data (2 of 2)


