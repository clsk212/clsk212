Hello, welcome!

First gonna explain the folder architecture:

	- src Folder: The source code folder! However, in languages that use headers (or if you have a framework for your application) don’t put those files in here.
	- test Folder: Unit tests, integration tests… go here.
	- .config Folder: It should local configuration related to setup on local machine.
	- .build Folder: This folder should contain all scripts related to build process (PowerShell, Docker compose…).
	- dep Folder: This is the directory where all your dependencies should be stored.
	- doc Folder: The documentation folder
	- res Folder: For all static resources in your project. For example, images.
	- samples Folder: Providing “Hello World” & Co code that supports the documentation.
	- tools Folder: Convenience directory for your use. Should contain scripts to automate tasks in the project, for example, build scripts, rename scripts. Usually contains .sh, .cmd files for example.

In order to correctly apply this model, please follow the next steps:
	
	1) Get your own audio plagiarism database (in wav format) or use the one provided in data folder.

	2) Pre-process this data by running "main" function in src folder. It creates a feature image for each audio, which gonna be the input for the neural network, and a dataset table.

	3) Once you've executed, it's turn to run "scnn" in order to define and train the network. Finally the net is trained and returns the evolution of model loss during training and the average accuracy of the net.

Thank you for your interest, and please contact me if you have any question or want to suggest improvements.

Carlos.
	