# Vector Space Model

## How to

- Need  
Prepare an English document set file and a stop-word list file.  
("../data_file/doc_set.txt", "../data_file/stop_words_list.txt")
- Run  
`$ julia search_in_vector_space_model.jl`
- Do  
Repeat keyword search for a set of documents by standard input.  
The top 10 items are displayed.  
The search is completed by entering "\end" or "\quit".  

## Files

|  Files                            |  Brief                                                                                     |
| --------------------------------- | ------------------------------------------------------------------------------------------ |
|  search_in_vector_space_model.jl  |  Based on the document information, a vector space model is constructed from the search words, and a search is performed.  |
|  handle_document.jl               |  Construct the document information needed to create a vector space model.                 |
|  evaluation_method.jl             |  Define weighting methods and similarity calculation methods.                              |
