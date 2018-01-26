package test;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by dmitrik on 6/27/2017.
 */
public class Main {
    private static Logger log = LoggerFactory.getLogger(Main.class);
    //

    public static void main(String[] args) {

        try {
            System.out.println("Usage: java " + Main.class.getName() + " <config-file> ");
        } catch (Throwable t) {
            log.error(t.getMessage(), t);
        }
    }
}
