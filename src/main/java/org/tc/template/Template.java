package org.tc.template;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sourceforge.argparse4j.ArgumentParsers;
import net.sourceforge.argparse4j.impl.Arguments;
import net.sourceforge.argparse4j.inf.ArgumentParser;
import net.sourceforge.argparse4j.inf.ArgumentParserException;
import net.sourceforge.argparse4j.inf.Namespace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Template 
{
	private static final String me = Template.class.getName();
    public static void main( String[] args ) {
    	int exitCode = 0;
    	Logger log = LoggerFactory.getLogger(Template.class);
    	// --------------------------
        ArgumentParser parser = ArgumentParsers.newArgumentParser(me)
        		.description("Demonstration of argparse4j");
        parser.addArgument("-t","--text").metavar("TEXTARG")
        		.dest("text").type(String.class)
        		.help("text option");
        parser.addArgument("-n","--number").metavar("NUMBER")
				.dest("number").type(Integer.class).setDefault(0)
				.help("integer argument");
        parser.addArgument("-f","--float").metavar("FLOATNUM")
				.dest("double").type(Double.class).setDefault(0.0)
				.help("double-precision float arg");
        parser.addArgument("-l","--log").metavar("LOGFILE")
        		.dest("log").type(String.class).setDefault(me + ".log")
        		.help("logging filename");
        parser.addArgument("-e","--env").metavar("KEY=VALUE")
        		.dest("env").action(Arguments.append())
        		.help("key=value pairs to be set");
        parser.addArgument("-v", "--verbose")
        		.dest("verbose").action(Arguments.storeTrue())
        		.help("run verbosely");
        parser.addArgument("targets").metavar("TARGETARG")
        		.type(String.class).nargs("*")
           		.help("remainder positional arguments");
    	// --------------------------
        Namespace res = null;
        Map<String,String> envMods = new HashMap<String,String>();
        try {
        	res = parser.parseArgs(args);
        } catch (ArgumentParserException e) {
        	log.error(e.getMessage());
        	parser.handleError(e);
        	exitCode = 1;
        } finally {
        	// pass
        }
    	//--------------------- TODO
        if (exitCode == 0) {
        	boolean verbose = res.getBoolean("verbose"); 
        	List<String> env = res.getList("env");
        	if (null != env) {
        		for (String ev : env) {
        			String[] evAry = ev.split("=");
        			if (evAry.length == 2) {
        				envMods.put(evAry[0], evAry[1]);
        			}
        		}
        	}
        	String txtOpt = res.getString("text");
        	log.info("text arg: {}", txtOpt != null ? txtOpt : "nada");
        	Integer n = res.getInt("number");
        	log.info("number arg: {}", n != null ? n : "null");
        	Double f = res.getDouble("double");
        	log.info("double arg: {}", f != null ? f.toString() : "null");
        	List<String> t = res.getList("targets");
        	int i = 0;
        	for (String a : t) {
        		log.info("{}: {}", i, a);
        		i += 1;
        	}
        }
    	System.exit(exitCode);
    }
}
