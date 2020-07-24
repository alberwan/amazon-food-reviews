

with sets(setStr, setDesc) as (values ('java -jar Z:\DataLine\Plans\DAVInCI\DV17403\NobleCoder-1.1.jar -terminology UMLS_NCI -input Z:\DataLine\Plans\DAVInCI\DV17403\InputFile.txt -output Z:\DataLine\Plans\DAVInCI\DV17403\Results -terminology C:\Users\thomass5\.noble\terminologies\UMLS_NCI.term -search all-match -negationDetection -stripSmallWords','all'), ('java -jar Z:\DataLine\Plans\DAVInCI\DV17403\NobleCoder-1.1.jar -terminology UMLS_NCI -input Z:\DataLine\Plans\DAVInCI\DV17403\InputFile.txt -output Z:\DataLine\Plans\DAVInCI\DV17403\Results -terminology C:\Users\thomass5\.noble\terminologies\UMLS_NCI.term -search best-match -negationDetection -stripSmallWords','best') )  

,allmatch as ( SELECT   * FROM     DVIDIC.DSGTOOLS_DV17403_NOBLEOUTPUT_V1_CUSTOMMATCH v1 inner join sets s1 on v1.searchstring = s1.setstr and s1.setDesc = 'all' )  , bestmatch as ( select * from DVIDIC.DSGTOOLS_DV17403_NOBLEOUTPUT_V1_CUSTOMMATCH v2 inner join sets s2 on v2.searchstring = s2.setstr and s2.setDesc = 'best' ) 

SELECT   case 
     when allmatch.conceptscore <> bestmatch.conceptscore then 'No' 
     else 'Yes' 
end as ConceptScoreMatch,
         allmatch.conceptscore as AllMatchScore,
         bestmatch.conceptscore as BestMatchScore,
         allmatch.PERMANENCE,
         allmatch.MATCHEDTERM,
         allmatch.CODE,
         allmatch.CONCEPTNAME,
         allmatch.SEMANTICTYPE,
         allmatch.ANNOTATIONS,
         allmatch.CERTAINTY,
         allmatch.CONTEXTUALASPECT,
         allmatch.CONTEXTUALMODALITY,
         allmatch.DEGREE,
         allmatch.EXPERIENCER,
         allmatch.PERMANENCE,
         allmatch.POLARITY,
         allmatch.TEMPORALITY
FROM     allmatch 
         inner join bestmatch on allmatch.NO_PRPT_PATH_RPT_ID = bestmatch.NO_PRPT_PATH_RPT_ID and allmatch.NO_PRPTDG_DX_GROUP_NUMBER = bestmatch.NO_PRPTDG_DX_GROUP_NUMBER and allmatch.CONCEPTNAME = bestmatch.conceptname and allmatch.annotations= bestmatch.annotations and allmatch.code = bestmatch.code
WHERE    allmatch.NO_PRPT_PATH_RPT_ID = 15499
ORDER BY allmatch.no_prpt_path_rpt_id, allmatch.NO_PRPTDG_DX_GROUP_NUMBER, 
         allmatch.annotations