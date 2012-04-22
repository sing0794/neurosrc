package convolution.rchannel;

import java.io.IOException;
import java.util.Iterator;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reducer;
import org.apache.hadoop.mapred.Reporter;

public class ConvolutionReducer extends MapReduceBase implements
		Reducer<Text, Text, Text, Text> {

	private final Text out_key = new Text();
	private final Text out_value = new Text();

	public void reduce(Text key, Iterator<Text> values,
			OutputCollector<Text, Text> output, Reporter reporter)
			throws IOException {

		long convolutionSum = 0;
		int counter = 0;

		while (values.hasNext()) {

			convolutionSum += Long.valueOf(values.next().toString());
			counter += 1;
			out_key.set(key);
			out_value.set(String.valueOf(convolutionSum/counter));

			output.collect(out_key, out_value);

		} // while
	} // reduce

}
