package rat.settings;

//import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.NullWritable;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.mapred.FileInputFormat;
import org.apache.hadoop.mapred.FileOutputFormat;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.util.Tool;
import org.apache.hadoop.util.ToolRunner;

public class SettingsJob extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {

		System.out.println("\n\nSettingsJob\n");
		JobConf conf = new JobConf(getConf(), SettingsJob.class);
		conf.setJobName("SettingsJob");
		
		conf.setMapperClass(SettingsMapper.class);
		List<String> other_args = new ArrayList<String>();
		for(int i=0; i < args.length; ++i) {
			try {
				if ("-m".equals(args[i])) {
					conf.setNumMapTasks(Integer.parseInt(args[++i]));
				} else if ("-r".equals(args[i])) {
					conf.setNumReduceTasks(Integer.parseInt(args[++i]));
				} else {
					other_args.add(args[i]);
				}
			} catch (NumberFormatException except) {
				System.out.println("ERROR: Integer expected instead of " + args[i]);
				return printUsage();
			} catch (ArrayIndexOutOfBoundsException except) {
				System.out.println("ERROR: Required parameter missing from " + args[i-1]);
				return printUsage();
			}
		}

		// Make sure there are exactly 2 parameters left.
		if (other_args.size() != 2) {
			System.out.println("ERROR: Wrong number of parameters: " + other_args.size() + " instead of 2.");
			return printUsage();
		}

		conf.setNumReduceTasks(0);
		//conf.setInputFormat(NonSplittableTextInputFormat.class);
		//conf.setOutputFormat(MultiFileOutput.class);
		conf.setOutputKeyClass(NullWritable.class);
		conf.setOutputValueClass(Text.class);
		conf.setCompressMapOutput(true);
		conf.set("mapred.output.compression.codec", "org.apache.hadoop.io.compress.SnappyCodec");
		conf.set("mapred.output.compression.type", "BLOCK");

		FileInputFormat.setInputPaths(conf, other_args.get(0));
		FileOutputFormat.setOutputPath(conf, new Path(other_args.get(1)));

		JobClient.runJob(conf);

		return 0;
	}

	static int printUsage() {
		System.out.println("SettingsJob [-m <maps>] [-r <reduces>] <input> <output>");
		ToolRunner.printGenericCommandUsage(System.out);
		return -1;
	}

	public static void main(String[] args) throws Exception {
		int res = ToolRunner.run(new Configuration(), new SettingsJob(), args);
		System.exit(res);

	}

}
