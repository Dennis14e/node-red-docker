# Contributing to Node-RED Docker

We welcome contributions, but request you follow these guidelines.

 - [Raising issues](#raising-issues)
 - [Feature requests](#feature-requests)
 - [Pull-Requests](#pull-requests)

This project adheres to the [Contributor Covenant 1.4](http://contributor-covenant.org/version/1/4/).
By participating, you are expected to uphold this code.

## Raising issues

Please raise any bug reports on the relevant project's issue tracker. Be sure to
search the list to see if your issue has already been raised.

A good bug report is one that make it easy for us to understand what you were
trying to do and what went wrong.

Provide as much context as possible so we can try to recreate the issue.
If possible, include the relevant part of your flow. To do this, select the
relevant nodes, press Ctrl-E and copy the flow data from the Export dialog.

At a minimum, please include:

 - Version of Node-RED - either release number if you downloaded a zip, or the first few lines of `git log` if you are cloning the repository directly.
 - Version of Node.js - what does `node -v` say?

## Feature requests

For feature requests, please raise them on the [Ideas discussion page](https://github.com/Dennis14e/node-red-docker/discussions/categories/ideas).

## Pull-Requests

If you want to raise a pull-request with a new feature, or a refactoring
of existing code, it may well get rejected if you haven't discussed it on
the [General discussion page](https://github.com/Dennis14e/node-red-docker/discussions/categories/general) first.

### Coding standards

Please ensure you follow the coding standards used through-out the existing
code base. Some basic rules include:

 - all files must have the Apache license in the header.
 - indent with 4-spaces, no tabs. No arguments.
 - opening brace on same line as `if`/`for`/`function` and so on, closing brace
 on its own line.
