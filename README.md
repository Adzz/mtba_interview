# Mtba

In this directory are two TSV files: one contains a listing of products by category,
and the other contains records of sales transactions for these products.

Question 1:  How many individual sales were made, and what's the total?

Question 2:  What are the top five categories by revenue?

Question 3:  What is the top-selling candy product?


## Answers

```sh
mix deps.get && iex -S mix
```

Then when in the REPL run the following:

```sh
Mtba.individual_sales() # question 1
Mtba.top_five_categories_by_revenue() # question 2
Mtba.top_five_categories_by_revenue() # question 2
```
