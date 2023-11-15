% Hypervolume-Based Evaluation and Ranking Technique (HEART) for Multi-Criteria Assessment
% Developed by Kaan Deveci (devecik@itu.edu.tr)
%
% This script implements the HEART methodology as presented in the following publication:
% Deveci, Kaan, and O. Guler. "Ranking Intuitionistic Fuzzy Sets with Hypervolume-Based Approach:
% An Application for Multi-Criteria Assessment of Energy Alternatives." Applied Soft Computing (2023): 111038.
%
% If you utilize this code or adapt it for your research, please cite the above-mentioned article.
%
% Licensed under the MIT License. You may not use this file except in compliance with the License.
% A copy of the License is available at https://opensource.org/licenses/MIT
%
% For the full license text, see the LICENSE file provided with this code.
%
% Disclaimer: This software is provided 'as is', without warranty of any kind, express or implied,
% including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement.
% In no event shall the authors be liable for any claim, damages or other liability, whether in an action of contract,
% tort or otherwise, arising from, out of or in connection with the software or the use or other dealings in the software.
%
% Additional Note: While this code currently only includes the HEART methodology, it is designed to be
% extensible. Researchers are welcome to extend this script by adding other methods at the end of the code as they see fit.
% However, currently only the HyperVolume-based approach is implemented in this project.

%% Initialization - Receiving Decision Matrices
%Define number of criteria, number of alternatives, and number of decision
%makers as below:
numberOfCriteria = 17;
numberOfAlternatives = 7;
numberOfDM = 3;
%Define intuitionistic fuzzy linguistic labels for cost and benefit criteria, 
%and for the importance of each criterion.Note that some DM may choose to use 
%their own IF evaluations rather than linguistic labels.
%Linguistic labels used for cost criteria: 
EH = [1 0];
VVH = [0.9 0.1];
VH = [0.8 0.10];
H = [0.7 0.2];
MH = [0.6 0.3];
F = [0.5 0.4];
ML = [0.4 0.5];
L = [0.25 0.6];
VL = [0.1 0.75];
VVL = [0.1 0.9];
%Linguistic labels used for benefit criteria:
EG = [1 0];
VVG = [0.9 0.1];
VG = [0.8 0.10];
G = [0.7 0.2];
MG = [0.6 0.3];
F = [0.5 0.4];
MB = [0.4 0.5];
B = [0.25 0.6];
VB = [0.1 0.75];
VVB = [0.1 0.9];
%Linguistic labels used for criteria importance:
VI = [0.9 0.10];
I = [0.75 0.2];
M = [0.5 0.45];
UI = [0.35 0.6];
VUI = [0.1 0.9];

%DM1:
DM1 = [0.6 0.2 0.8 0.2 0.7 0.3 0.8 0.1 0.9 0.1 0.75 0.25 0.5 0.2 0.5 0.4
 H VH 0.75 0.1 H H MH H MH 
 H MH H 0.6 0.2 0.8 0.1 0.9 0.05 H VH
 0.6 0.1 0.7 0.2 0.8 0.1 0.8 0.2 0.8 0.1 0.85 0.1 0.6 0.2 0.7 0.1
 H EH VH MH F H H VH 
 VH MH VH 0.7 0.3 H VH EH EH 
 H VH VH VVH VVH VVL VH VH
 MH L L VL VL VL MH VH 
 F EH MH VH H EH F F
 VH VL VVH VL VL VL MH H
 VH VH H VVH VVH F MH L
 VH VVH VH EH EH F H L
 H MH H VH VVH VH H L
 VH VVH VH MH MH H VH VVH
 VH EH VVH F 0.25 0.6 VH 0.3 0.6 MH
 VH VH VH VVH EH 0.5 0.1 H F 
 H MH H VH VVH H 0.6 0.2 0.5 0.1];

%DM2:
DM2 = [ VG	EG	VG	EG	EG	MG	MG	MG
VH	MH	VH	MH	VH	VH	VH	VH
VG	MG	VG	MG	VG	VG	VG	VG
MH	VH	H	H	H	H	MH	MH
VH	VVH	VH	L	VL	H	H	VH
H	L	H	L	H	L	VH	VH
H	VH	VH	VH	VH	VVL	VH	VH
H	L	H	VVL	VVL	VVL	L	VH
L	H	L	H	VH	H	L	L
H	VL	L	VVL	VVL	VVL	VL	H
G	VG	G	EG	EG	EG	MG	B
VG	VVG	VG	EG	EG	G	MG	MG
VG	MG	MG	VG	EG	G	MB	VB
VG	G	VG	G	MG	G	G	VVG
H	EH	H	MH	F	EH	VH	VH
MG	G	G	VG	VG	G	MG	B
G	G	G	VG	VG	G	MG	MG];

%DM3:
DM3 = [VG	VVG	F	VVG	EG	MG	MG	G
MH	VL	F	H	MH	VH	VL	VL
VVG	VG	VG	B	MB	F	EG	EG
H	EH	H	VH	ML	EH	F	MH
MH	VVH	MH	MH	VL	VH	H	H
VVG	VVG	VG	MB	B	F	VG	G
G	EG	G	VG	G	B	VVG	VVG
MH	VL	ML	F	ML	MH	VH	VVH
F	H	ML	EH	VVH	EH	F	F
VVH	VL	VVL	MH	F	H	H	VVH
VH	VVH	H	EH	EH	MH	H	H
F	VH	ML	VH	VVH	VL	MH	H
H	F	H	H	VVH	ML	F	L
MH	H	F	ML	MH	L	F	F
H	EH	VH	L	VVL	VVH	H	H
H	F	MH	VVH	VH	VH	VL	VL
MG	G	F	VG	VG	VVG	G	MG];

% For this example, 
DMMatrix = [DM1;DM2;DM3];
DMMatrix(:,11:12) = []; 

%Criteria importance matrix, defined by decision makers:
criteriaImportance = [0.85 0.1 0.85 0.1 0.85 0.1 0.85 0.1 0.85 0.1 0.85 0.1 0.85 0.1 0.7 0.2 0.7 0.2 0.7 0.2 0.8 0.2 0.8 0.2 0.8 0.2 0.8 0.2 0.9 0.05 0.9 0.05 0.9 0.05
                      VI VI VI VI VI VI VI I I I I I I I VI VI VI
                      I I I I I I I M M M M M M M VI VI VI];
%% Rearranging format of decision matrix as in Table 7:
% A1: DM1-C1, DM1-C2, DM1-C3,...
% A1: DM2-C1, DM2-C2, DM2-C3,...
% A1: DM3, ...
% A2: ...
% ...
for i = 1:numberOfCriteria
    for j = 1:numberOfAlternatives
        for k = 1:numberOfDM
            decisionMatrix((j-1)*numberOfDM+k,(i-1)*2+1:(i-1)*2+2) = DMMatrix((k-1)*17+i,(j-1)*2+1:(j-1)*2+2);
        end
    end
end

%DM Accuracy Matrix, defined by DM themselves:
DMAccuracyMatrix = [0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.8 0.8 0.8
                    0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.8 0.8 0.8
                    0.85 0.85 0.85 0.85 0.85 0.85 0.85 0.6 0.6 0.6 0.75 0.75 0.75 0.75 0.8 0.8 0.8];
                