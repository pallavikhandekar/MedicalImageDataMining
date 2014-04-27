import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import weka.core.*;
import weka.attributeSelection.*;

public class ImportWekaToJava {

	public static void main(String[] args)
	{
	try {
		BufferedReader reader = new BufferedReader(
		        new FileReader("/Users/palloabhi/Documents/WorkspaceEclipse/DataMiningImages/ImportJ48IntoJava/input.arff"));
		try {
			//Read arff file and create instance.
			Instances trainingData = new Instances(reader);
			//set the classindex Class {3,4,5,1}
			trainingData.setClassIndex(trainingData.numAttributes()-1);
			
			//Feature Selection
			AttributeSelection attrSelection = new AttributeSelection();
			InfoGainAttributeEval evalAttribute = new InfoGainAttributeEval();
			Ranker ranker = new Ranker();
			
			attrSelection.setEvaluator(evalAttribute);
			attrSelection.setSearch(ranker);
			attrSelection.SelectAttributes(trainingData);
			
			System.out.println(attrSelection.toResultsString());
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 
	} catch (FileNotFoundException e) {
		// TODO Auto-generated catch block
				e.printStackTrace();
	}
	catch(Exception e){
		// TODO Auto-generated catch block
	e.printStackTrace();
	}
	
	
	}
}
