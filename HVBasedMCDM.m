% Hypervolume-Based Evaluation and Ranking Technique (HEART) for Multi-Criteria Assessment
% Code developed by Kaan Deveci (devecik@itu.edu.tr)
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
%% Step 4: Normalize aggregated IF decision matrix, by converting all cost criteria in to benefit criteria.
%% Users can revise the MCDM steps starting from here, depending on the distance based MCDM method.
costCriteria = setdiff([1:numberOfCriteria],benefitCriteria);
normalizedAggregatedIF = aggregatedEvaluationMatrix;
for cc = 1:length(costCriteria)
    for rr = 1:numberOfAlternatives
        normalizedAggregatedIF(costCriteria(cc),(rr-1)*2+1:rr*2) = [normalizedAggregatedIF(costCriteria(cc),(rr-1)*2+2) normalizedAggregatedIF(costCriteria(cc),(rr-1)*2+1)];
    end
end
NAIFDM=normalizedAggregatedIF;
save NAIFDM.txt NAIFDM -ascii

%% Step 5: Construct the weighted normalized aggregated IF evaluation matrix.
product = [];
for i = 1:numberOfCriteria
    for j = 1:numberOfAlternatives
        aggEvMat = NAIFDM(i,2*j-1:2*j);
        aggIFCriMat=aggregatedIFCriteriaMatrix(i,:);
        weightedNormalizedAggregatedIF(i,2*j-1:2*j) = [aggEvMat(1)*aggIFCriMat(1),aggEvMat(2)+aggIFCriMat(2)-aggEvMat(2)*aggIFCriMat(2)];
    end
end

%% Step 6: Calculate the HV metrics for both the membership and non-membership decision spaces.
membership_indices = 1:2:2*numberOfCriteria;
nonmembership_indices = 2:2:2*numberOfCriteria;

for i = 1:numberOfAlternatives
    vectorMem = weightedNormalizedAggregatedIF(:,membership_indices(i));
    vectorNonMem=weightedNormalizedAggregatedIF(:,nonmembership_indices(i));
    vectorHes = 1- vectorMem - vectorNonMem;
    hyperVolMem(i) = prod(abs(vectorMem-(-1)));
    hyperVolNonMem(i)=prod(abs(vectorNonMem-(-1)));
    %hyperVolHes(i) = prod(abs(-1-vectorHes)); %for future research
end
HV_net = hyperVolMem-hyperVolNonMem;

%% Step 7: Rank the alternatives based on HV_net.
[sd,r]=sort(HV_net,'descend');
r