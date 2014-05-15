package ut.be.sofico.bamboo.plugins;

import org.junit.Test;
import be.sofico.bamboo.plugins.MyPluginComponent;
import be.sofico.bamboo.plugins.MyPluginComponentImpl;

import static org.junit.Assert.assertEquals;

public class MyComponentUnitTest
{
    @Test
    public void testMyName()
    {
        MyPluginComponent component = new MyPluginComponentImpl(null);
        assertEquals("names do not match!", "myComponent",component.getName());
    }
}