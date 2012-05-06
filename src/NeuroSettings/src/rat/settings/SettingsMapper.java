package rat.settings;

import java.io.File;
//import java.io.FileReader;
import java.io.IOException;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reporter;

public class SettingsMapper extends MapReduceBase implements
		Mapper<LongWritable, Text, NullWritable, Text> {

	static enum Parse_Counters {
		BAD_PARSE
	};

	private final Text out_value = new Text();

	private int n = 0;

	private String ratnumber;
	private	String sessiondate;
	private String channelid;

	@Override
	public void configure(JobConf conf) {
		
		try {
			getSessionSettings(conf);
		} catch (IOException ioe) {
			System.err.println("IOException reading from distributed cache");
			System.err.println(ioe.toString());
		}
	}

	public void getSessionSettings(JobConf conf) throws IOException {
		String fpath = conf.get("map.input.file");
		String fname = new File(fpath).getName();

		int indexBegin = 0;
		int indexEnd = fname.indexOf('-');

		ratnumber = fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd+1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd+1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = sessiondate + '-' + fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd+1;
		indexEnd = fname.indexOf('-', indexBegin);
		sessiondate = sessiondate + '-' + fname.substring(indexBegin, indexEnd);
		indexBegin = indexEnd+4;
		indexEnd = fname.indexOf('.', indexBegin);
		channelid = fname.substring(indexBegin, indexEnd);

	}

	public void map(LongWritable inkey, Text value,
		OutputCollector<NullWritable, Text> output,
		Reporter reporter) throws IOException {

		try {
			if (n==0) {
				n=1;
				out_value.set(
					ratnumber + "," +
					sessiondate + "," +
					channelid)
				;
				output.collect(NullWritable.get(), out_value);
			}
					
		} catch (IOException ioe) {
			System.err.println(ioe.getMessage());
			System.exit(0);
	   }
	} // map

}
	