package convolution.hive.udaf;

import org.apache.hadoop.hive.ql.exec.UDAF;
import org.apache.hadoop.hive.ql.exec.UDAFEvaluator;

/**
 * This is a simple UDAF that does group concat.
 * 
 */
public final class NGroupConcat extends UDAF {

  /**
   * The actual class for doing the aggregation. Hive will automatically look
   * for all internal classes of the UDAF that implements UDAFEvaluator.
   */
  public static class NGroupConcatEvaluator implements UDAFEvaluator {

    String state;

    public NGroupConcatEvaluator() {
      super();
      init();
    }

    /**
     * Reset the state of the aggregation.
     */
    public void init() {
      state = "";
    }

    /**
     * Iterate through one row of original data.
     * 
     * The number and type of arguments need to the same as we call this UDAF
     * from Hive command line.
     * 
     * This function should always return true.
     */
    public boolean iterate(String o) {
      if (o != null) {
        state = state.concat(o);
      }
      return true;
    }

    /**
     * Terminate a partial aggregation and return the state. If the state is a
     * primitive, just return primitive Java classes like Integer or String.
     */
    public String terminatePartial() {
      // This is SQL standard - average of zero items should be null.
      return state;
    }

    /**
     * Merge with a partial aggregation.
     * 
     * This function should always have a single argument which has the same
     * type as the return value of terminatePartial().
     */
    public boolean merge(String o) {
      if (o != null) {
        state = state.concat(o);
      }
      return true;
    }

    /**
     * Terminates the aggregation and return the final result.
     */
    public String terminate() {
      // This is SQL standard - average of zero items should be null.
      return state;
    }
  }

  private NGroupConcat() {
    // prevent instantiation
  }

}
