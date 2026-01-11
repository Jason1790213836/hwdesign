---
title: AI Auto-grader
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

I still need to find a good webserver, but eventually,
you will go the webserver with the AI-grader.
You will see several buttons:

* **Unit dropdown**:  You should see a dropdown menu of the units you
in the class you can problems for.  These are the [class units](../nyu/index.md).  Right now, there is just
one unit `basic_logic`.   
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

## Using a Latex File

Instead of manually typing in the solution to each question,
you can load them from a latex file. 
The solution file, say `my_soln.tex` should be of the form:

```latex
\beign{enumerate}

\item Question 1 text  

\begin{solution}  Enter your solution here
\end{solution}

\item Question 2 text
\begin{solution}  Enter your solution here
\end{solution}
...

\end{enumerate}
```

Once you load the file, the server will strip the 
solutions in the `{solution}` environment. 
You do not need to compile the `tex` file.  In fact, it
does not even need to compile.  You can write the
solution in Latex, but any text is fine.  It is just a placeholder.  






