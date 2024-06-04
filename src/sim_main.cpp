#include <iostream>
#include <verilated.h>
#include "verilated_vcd_c.h"
#include "Vtb.h"

int main(int argc, char **argv)
{
    // Construct context object, design object, and trace object
    VerilatedContext *m_contextp = new VerilatedContext; // Context
    VerilatedVcdC *m_tracep = new VerilatedVcdC;         // Trace
    Vtb *m_duvp = new Vtb;                 // Design
    // Trace configuration
    m_contextp->traceEverOn(true);     // Turn on trace switch in context
    m_duvp->trace(m_tracep, 3);        // Set depth to 3
    m_tracep->open("sim.vcd"); // Open the VCD file to store data
    // Write data to the waveform file
    unsigned int time = 0;
    int d = 0;
    m_duvp->clk = 0;
    m_duvp->rst = 1;
    m_duvp->eval();

    m_duvp->rst = 0;
    m_duvp->eval();
    time++;
    m_duvp->rst = 1;
    m_duvp->eval();

    
    while (d != 1)
    {
        // Refresh circuit state
	if (m_duvp->clk == 0){
            m_duvp->clk = 1;
	}else{
	    m_duvp->clk = 0;
	}
        m_duvp->eval();
	time++;
	d = m_duvp->_done;
	std::cout << time << " - ";
	std::cout << d << std::endl;
        // Dump data
        m_tracep->dump(m_contextp->time());
        // Increase simulation time
        m_contextp->timeInc(1);
    }
    // Remember to close the trace object to save data in the file
    m_tracep->close();
    // Free memory
    delete m_duvp;
    return 0;
}
