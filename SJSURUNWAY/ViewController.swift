//
//  ViewController.swift
//  SJSURUNWAY
//
//  Created by Michael Ong on 4/25/18.
//  Copyright © 2018 Michael Ong. All rights reserved.
//

import UIKit

public class Vertex {
    var key: String?
    var neighbors: Array<Edge>
    var start: Bool
    var end: Bool
    
    init() {
        self.neighbors = Array<Edge>()
        self.start = false
        self.end = false
    }
}

public class Edge {
    var neighbor: Vertex
    var weight: Int
    
    init() {
        weight = 0
        self.neighbor = Vertex()
    }
}



public class SwiftGraph {
    private var canvus: Array<Vertex>
    public var isDirected: Bool
    
    var NPG = Vertex()
    var KING = Vertex()
    var SCI = Vertex()
    var CL = Vertex()
    var ENGR = Vertex()
    var SU = Vertex()
    var SWC = Vertex()
    var WPG = Vertex()
    var SPG = Vertex()
    var CV = Vertex()
    
    init() {
        canvus = Array<Vertex>()
        isDirected = false //Makes the graph nondirectional
    }
    func addVertex(key: String) -> Vertex {
        var childVertex: Vertex = Vertex()
        childVertex.key = key
        canvus.append(childVertex)
        return childVertex
    }
    
    
    
    func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        var newEdge = Edge()
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        if (isDirected == false) {
            var reverseEdge = Edge()
            reverseEdge.neighbor = source
            reverseEdge.weight = weight
            neighbor.neighbors.append(reverseEdge)
        }
    }
    
    func buildGraph() -> SwiftGraph{
        var graph = SwiftGraph()
        
        NPG = graph.addVertex(key: "NPG")
        KING = graph.addVertex(key: "KING")
        SCI = graph.addVertex(key: "SCI")
        CL = graph.addVertex(key: "CL")
        ENGR = graph.addVertex(key: "ENGR")
        SU = graph.addVertex(key: "SU")
        SWC = graph.addVertex(key: "SWC")
        WPG = graph.addVertex(key: "WPG")
        SPG = graph.addVertex(key: "SPG")
        CV = graph.addVertex(key: "CV")
        
        graph.addEdge(source: CV, neighbor: SPG, weight: 4)
        graph.addEdge(source: CV, neighbor: SWC, weight: 4)
        graph.addEdge(source: CV, neighbor: SU, weight: 4)
        graph.addEdge(source: CV, neighbor: NPG, weight: 6)
        graph.addEdge(source: NPG, neighbor: ENGR, weight: 2)
        graph.addEdge(source: ENGR, neighbor: SU, weight: 1)
        graph.addEdge(source: ENGR, neighbor: CL, weight: 1)
        graph.addEdge(source: CL, neighbor: KING, weight: 2)
        graph.addEdge(source: CL, neighbor: SU, weight: 1)
        graph.addEdge(source: KING, neighbor: SCI, weight: 1)
        graph.addEdge(source: SCI, neighbor: WPG, weight: 4)
        graph.addEdge(source: SCI, neighbor: SWC, weight: 3)
        graph.addEdge(source: WPG, neighbor: SPG, weight: 2)
        graph.addEdge(source: SPG, neighbor: SWC, weight: 2)
        graph.addEdge(source: SWC, neighbor: SU, weight: 2)
    
        return (graph)
    }
}


class ViewController: UIViewController {
    @IBOutlet weak var timedisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
    @IBAction func Dykstra(_ sender: UIButton) {
        
        var graph = SwiftGraph()
        graph = graph.buildGraph()
        
        var start = false, end = false;
        var vertexStart = Vertex()
        var vertexEnd = Vertex()
        var result = 0;
        
        if(sender.tag == 0){
            if(start == false){
                start = true
                vertexStart = graph.NPG
            }
            else if(end == false){
                end = true
                vertexEnd = graph.NPG
            }
        }
        if(sender.tag == 1){
            if(start == false){
                start = true
                vertexStart = graph.KING
            }
            else if(end == false){
                end = true
                vertexEnd = graph.KING
            }
        }
        if(sender.tag == 2){
            if(start == false){
                start = true
                vertexStart = graph.CL
            }
            else if(end == false){
                end = true
                vertexEnd = graph.CL
            }
        }
        if(sender.tag == 3){
            if(start == false){
                start = true
                vertexStart = graph.ENGR
            }
            else if(end == false){
                end = true
                vertexEnd = graph.ENGR
            }
        }
        if(sender.tag == 4){
            if(start == false){
                start = true
                vertexStart = graph.SCI
            }
            else if(end == false){
                end = true
                vertexEnd = graph.SCI
            }
        }
        if(sender.tag == 5){
            if(start == false){
                start = true
                vertexStart = graph.SU
            }
            else if(end == false){
                end = true
                vertexEnd = graph.SU
            }
        }
        if(sender.tag == 6){
            if(start == false){
                start = true
                vertexStart = graph.SWC
            }
            else if(end == false){
                end = true
                vertexEnd = graph.SWC
            }
        }
        if(sender.tag == 7){
            if(start == false){
                start = true
                vertexStart = graph.WPG
            }
            else if(end == false){
                end = true
                vertexEnd = graph.WPG
            }
        }
        if(sender.tag == 8){
            if(start == false){
                start = true
                vertexStart = graph.SPG
            }
            else if(end == false){
                end = true
                vertexEnd = graph.SPG
            }
        }
        if(sender.tag == 9){
            if(start == false){
                start = true
                vertexStart = graph.CV
            }
            else if(end == false){
                end = true
                vertexEnd = graph.CV
            }
        }
        if(start == true && end == true){
            timedisplay.text = "\(vertexStart.key), \(vertexEnd.key)"
        }
        //if(start == true && end == true
        //{
        //  result = dijkstra (vertexStart , vertexEnd)
        //  timedisplay.text = "\(result)"
        //  vertexStart = false
        //  vertexEnd = false
        //  reset start and end and vertexStart and vertexEnd
        //}
    }
}

