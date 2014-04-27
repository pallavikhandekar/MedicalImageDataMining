import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import weka.classifiers.Evaluation;
import weka.classifiers.meta.FilteredClassifier;
import weka.classifiers.trees.J48;
import weka.core.*;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;
import weka.attributeSelection.*;

public class ImportWekaToJava {

	public static void main(String[] args)
	{
	try {
		BufferedReader reader = new BufferedReader(
		        new FileReader("/Users/palloabhi/Documents/WorkspaceEclipse/DataMiningImages/MedicalImageDataMining/ImportJ48IntoJava/input.arff"));
		try {
			//Read arff file and create instance.
			Instances data = new Instances(reader);
			//set the classindex Class {3,4,5,1}
			data.setClassIndex(data.numAttributes()-1);
			
			//Feature Selection
			AttributeSelection attrSelection = new AttributeSelection();
			InfoGainAttributeEval evalAttribute = new InfoGainAttributeEval();
			Ranker ranker = new Ranker();
			
			attrSelection.setEvaluator(evalAttribute);
			attrSelection.setSearch(ranker);
			attrSelection.SelectAttributes(data);
			
			Remove rm = new Remove();
			//Remove Attributes will 0 information gain
			rm.setAttributeIndicesArray(new int[]{6,8,7,3,5,2,10,4,9,13,11,19,20,12,18,17,16,15,14,1});
			rm.setInputFormat(data);
			Instances trainingData = Filter.useFilter(data, rm);
			//System.out.println(trainingData.numAttributes());
			
			J48 j48 = new J48();
			j48.setUnpruned(true);        // using an unpruned J48
			 // meta-classifier
			FilteredClassifier fc = new FilteredClassifier();
			fc.setClassifier(j48);
			 // train and make predictions
			fc.buildClassifier(trainingData);
			
			Evaluation eval = new Evaluation(trainingData);
			eval.evaluateModel(fc, trainingData);
			System.out.println(eval.toSummaryString("\nResults\n======\n", false));
			 
			
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
