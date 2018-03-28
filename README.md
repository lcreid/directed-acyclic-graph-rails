# Directed Acyclic Graphs in Rails
## Introduction
This repository contains implementations of directed acyclic graphs in Rails applications. It includes UI techniques as well as the model level. It's meant to serve as a starter implementation for real applications that can benefit from a directed acyclic graph (DAG) implementation.

(Unfortunately, there are at least two uses of the work "graph" in mathematics. One is to show a plot of values of a function. The other is a data structure that we're talking about here.)

A DAG is a data structure that has:
- vertexes (math term) or nodes (term often used by practising programmers)
- edges (math term) or links (term often used by practising programmers)
- the edges have a "direction", meaning that the edge as a "start" and an "end" for some definition of "start" and "end"
- there is no way to start at a vertex, follow the edges, and return to the starting vertex. This is the "acyclic" part

DAGs are the natural representation of "parent-child" relationships.

This branch demonstrates a user interface that on one page:
- Allows the user to edit the vertex
- Allows the user to assign parents and children. Specifically, the user is presented with a list of check boxes, one for each vertex. There's one list of parents and another for children.
- Provides immediate feedback to prevent the user from putting cycles in the graph. Specifically, when the user selects a vertex as a child, the child and all its descendents are disabled in the list of possible parent vertexes. And when the user selects a vertex as a parent, the parent and all its ancestors are disabled in the list of possible child vertexes

## Model
In Rails terms, the model is a self-referential many-to-many association. Although the number of lines of code is small, the code is a bit fussy. You have to get things just right, or certain cases will mysteriously fail, even when the majority is working right.

The implementation in this repository is a simple one. http://www.rubydoc.info/gems/acts-as-dag/4.0.0 is an implementation of a DAG model with more optimizations.

## Controllers and Views
The controllers and views are more interesting. The new/edit page for a vertex contains two lists of check boxes. One list is for the children of the vertex being edited. The other is for parents of the vertex being edited.

It's impossible to provide immediate feedback with the basic "submit button" approach given this layout. The approach used here is to catch change events on the check boxes, and refresh the vertexes in the other list. Note that the constraint is such that a click on a check box in the child list affects which check boxes are disabled in the parent list, and vice versa.

This approach has problems when the vertex hasn't been saved yet (is new), so all the check boxes are disabled until the vertex is saved.
