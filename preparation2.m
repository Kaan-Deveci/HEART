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

%% Step 1: Obtain DM evaluation matrix in corresponding format.
% The order of ranking for alternatives are: Biomass, hydroelectricity,
% geothermal, onshore wind, solar PV, natural gas, and  coal.
matrix = decisionMatrix;
criteriaWeights = criteriaImportance;
benefitCriteria = [1 3 6 7 11 12 13 14 16 17]; %Define the set of benefit criteria

%% Step 2: Calculate aggregated DM Evaluation matrix
for j = 1:numberOfCriteria
    for i = 1:numberOfAlternatives
        membership = matrix((i-1)*numberOfDM+1:i*numberOfDM,(j*2-1));
        nonmembership = matrix((i-1)*numberOfDM+1:i*numberOfDM,(2*j));
        IFAMembershipMatrix(j,i) = sum(membership.*DMAccuracyMatrix(:,j))/sum(DMAccuracyMatrix(:,j));
        IFANonMembershipMatrix(j,i) = sum(nonmembership.*DMAccuracyMatrix(:,j))/sum(DMAccuracyMatrix(:,j));
    end
end
for i = 1:numberOfAlternatives
    aggregatedEvaluationMatrix(:,i*2-1:2*i) =[IFAMembershipMatrix(:,i) IFANonMembershipMatrix(:,i)]; 
end
save aggregatedEvaluationMatrix.txt aggregatedEvaluationMatrix -ascii

%% STEP 3: Calculate aggregated IF criteria matrix
for j = 1:numberOfCriteria
    membership = criteriaWeights(:,(j*2-1));
    nonmembership = criteriaWeights(:,(2*j));
    dummyMembership(j) = sum(membership.*DMAccuracyMatrix(:,j))/sum(DMAccuracyMatrix(:,j));
    dummyNonMembership(j) = sum(nonmembership.*DMAccuracyMatrix(:,j))/sum(DMAccuracyMatrix(:,j));
end
aggregatedIFCriteriaMatrix = [dummyMembership' dummyNonMembership'];
save aggregatedIFCriteriaMatrix.txt aggregatedIFCriteriaMatrix -ascii

%% Run the method you want:
% Note: This code is designed to be modular and can be augmented with additional MCDM 
% methods such as CODAS, EDAS, VIKOR, and TOPSIS. These distance-based methods share 
% initial steps and can be integrated into the code with any user-defined routines.
%IFCODASR
%IFEDASR
%IFVIKORR
%IFTOPSISR
HVBasedMCDM