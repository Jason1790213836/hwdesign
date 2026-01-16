---
title: AI Autograder
parent: Hardware Design
nav_order: 4
has_children: false
---

# AI Autograder

As an experimental part of the course, I am playing around
with an LLM-based autograder.  If it is successful,
you will be able to upload solutions and get immediate
feedback from an advanced AI engine.

## How to Use It
Right now, a barebones server is hosted on [Render](https://llmgrader-e6o7.onrender.com).
As I am building the site, it may change and go off temporarily. When it is working, hopefully you will see:

* **Unit dropdown**:  You should see a dropdown menu of the units you
in the class you can problems for.  These are the [class units](../nyu/index.md).  Right now, there is just
one unit `unit1_basic_logic`.   
* **Question dropdown**:  Once you select the unit, you should see a dropdown menu of questions.  These are the questions
in the Problem section for that unit.  The [class units page](../nyu/index.md) has the questions.
* **Question Box**:  After you select a question a text version
of the question will appear.  It is plain text,
so code blocks and equations are rendered very simply, 
and there are no figures.  But you can go the PDF on class units
page if you want to see the full questions.
* **Solution box**:  Here you can type in a solution to grade.
You can write it in latex if you like, but text is OK too.
The LLM is pretty good at figuring out what you are trying to say.
* **Grade button**:  Hit the grade button and in a few tens of seconds, you should see a **Feedback** and a longer **Explanation**.  Right now, it just gives **Correct** or **Incorrect**.  I may give part marks later.


## OpenAI Key

The grader is based on [OpenAI's API platform](https://openai.com/api/) which provides access to its powerful GPT models.
To use the autograder:

* Go to the [OpenAI's API platform](https://openai.com/api/) page
* **Log In**.  If you do not have an account, you will be asked to create one
* Go to the [API Key page](
https://platform.openai.com/account/api-keys) page.
* Create a OpenAI key.  
* Go back to the Autograder webpage and paste the key in the **OpenAI key** box in the top right.

**Important notes**
- Your API key is never stored on the server.
It stays entirely in your browser (using local storage) and is only sent with your grading request so the model can run. The server does not save, log, or retain your key.
- Costs are typically very low.
Each grading request uses only a small amount of model compute, so even frequent use should remain inexpensive. You can monitor your usage at any time on your OpenAI dashboard.

## Which model to use?

To the right of the **Grade** button, you will see a dropdown menu to select a model to use.  These are my findings so far:

* `gpt-4.1.-mini`:  This is the fastest, about 10-20 seconds for a response.  On simple problems, this would be my choice.  But, on problems
where the model has to reason over multiple clock cycles it makes mistakes.
* `gpt-5-mini`:  This is slower, about 1-2 minutes for a response.  But, it can reason very well on more complex problems.

Both models are very cheap.  Less than a dollar for a million tokens. 

## Saving and Loading Your Work

To **save** your results, beside the Unit dropdown, you will see a button **Save Results**.  For all problems in the unit that you have attempted to grade,
clicking the button will save:
- Your solution
- The feedback from OpenAI
- The full explanation
- The grade result

This will be downloaded to a JSON file to your Download folder.  You can store anywhere.

Your answers are generally served on your browser.  But, if you want to recover them you can click the **Load Results** button and select the JSON file that you
save above.

## Submitting Your Work for Grading
For NYU students requiring to get a formal grade, do the following:

* Answer the problems that are required.  Note that in the top right, there is a display of **Optional** or **Points** for each problem.
You can skip problems that are optional.  Note that you will be expected to be answer all problems on the midterm and final.
* Attempt the problems for as many times as you like until you get correct on them.
* Once you are satisfied, follow the instructions above to **Save Results**.  The saving will produce a JSON file. Submit that JSON file in Gradescope.

In Gradescope, we will run an auto-grader will upload the results.

You may feel that you have a correct solution, but the AI may disagree.  No worries.  The AI can make mistakes.  After you upload your solution JSON, submit
a regrade request on Gradescope, and I will correct manually.

## Using a Latex File

Instead of manually typing in the solution to each question,
you can load them from a latex file. 
Download the problem Latex file from the github page.  The file,
such as `basic_logic_prob.tex` will be of the form:


```latex
\beign{enumerate}

\item \qtag{tag1} Question 1 text  

\begin{solution}  Enter your solution here
\end{solution}

\item \qtag{tag1} Question 2 text
\begin{solution}  Enter your solution here
\end{solution}
...

\end{enumerate}
```

Fill in the solutions and do change any of the other text inside the enumerate
-- the fields such as `\qtag{}` are needed for the parsing.  Once you are done with the
file, simply choose the file in the **Latex solution** dialog box and select **Load**.
Loading the solutions will populate solutions to all the questions and clear the 
grading responses for that unit.






