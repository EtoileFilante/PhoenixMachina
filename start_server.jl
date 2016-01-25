using HttpServer
using LightXML

include("config.jl")
http = HttpHandler() do req::Request, res::Response
    if ismatch(r"PhoenixMachina$",req.resource)||ismatch(r"PhoenixMachina/$",req.resource)
      include(string(HOME_URL,"controllers/",HOME_CONTROLLER))
      getContent(req,res)
    elseif ismatch(r"^/PhoenixMachina/",req.resource)
      m = match(r"^/PhoenixMachina/[a-z]",req.resource)
      include(string(HOME_URL,"controllers/",(m.match)[17:end],"Controller.jl"))
      getContent(req,res)
    else
    Response("404")
    end
end

server = Server( http )
run( server, 8000 )
