HYPERVOLUME-BASED EVALUATION AND RANKING TECHNIQUE (HEART)

This repository contains the MATLAB implementation of the Hypervolume-Based Evaluation and Ranking Technique (HEART) for Multi-Criteria Decision Making, as described in the forthcoming publication:

Deveci, Kaan, and O. Guler. "Ranking Intuitionistic Fuzzy Sets with Hypervolume-Based Approach: An Application for Multi-Criteria Assessment of Energy Alternatives." Applied Soft Computing (forthcoming): 111038.
Please note that the publication date is anticipated to be in 2023 but may be subject to change. 
The correct citation will be updated upon official publication.

GETTING STARTED

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

PREREQUISITES

What things you need to install the software and how to install them:
MATLAB (or Octave, as an open source alternative to MATLAB)
Do not forget to hold all files in the working directory.

INSTALLING

A step by step series of examples that tell you how to get a development environment running:
1. Clone the repo: git clone https://github.com/yourusername/HEART.git
2. Navigate to the cloned directory: cd HEART
3. Open MATLAB and navigate to the directory as well.
4. Run the initial script: "main.m".

USAGE

This project consists of four files: main.m, preparation1.m, preparation2.m, and HVBasedMCDM.m.

Running the main.m MATLAB script will reproduce the results presented in the publication for HEART. This script sequentially executes preparation1.m, preparation2.m, and HVBasedMCDM.m.

In preparation1.m, you will find the survey results reflecting how decision-makers evaluate alternatives according to certain criteria, along with the weights of criteria and self-evaluation assessments. DM evaluations and the linguistic scale utilized in the file can be revised as needed.

The preparation2.m file computes the first three steps common to distance-based MCDM methods described in the article. Users can build upon this code to incorporate other methods if desired. To do this, remove the HVBasedMCDM line at the end of the file and append your own code starting from Step 4.

The HVBasedMCDM.m file encompasses Steps 4-7 from the article. It processes the normalization of benefit-cost criteria, finds the weighted normalized aggregated evaluation matrix, and carries out the hypervolume calculation. Rankings are then generated based on the computed HV_net values.

CONTRIBUTING

If you would like to contribute to the HEART project or have any questions, feel free to reach out. You can contribute via the GitHub repository by creating pull requests or opening issues for any bugs or enhancements you have identified. For direct communication or specific inquiries, please do not hesitate to send an email to devecik@itu.edu.tr.

AUTHORS

Kaan Deveci

LICENSE

This project is licensed under the MIT License - see the LICENSE.txt file for details.
