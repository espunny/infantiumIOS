//
//  infantiumAPI.h
//  Chup ON
//
//  Created by Rubén García on 21/02/13.
//
//

#import <Foundation/Foundation.h>

@interface infantiumAPI : NSObject{
    
    NSMutableData *responseData;
    NSString *uriplayer; // contiene la ruta del jugador cuando ya se ha creado.
    NSString *uritutor; //  Contiene la ruta del tutor
    NSString *uriGame; //   Partida
    
    NSString *edad;
    NSString *nickname;
    NSInteger codigoestado; // Código de estado de respuesta del server
    NSString *salida;
    
    //Modo de trabajo
    NSInteger modo;
}
@property (nonatomic, retain)NSMutableData *responseData;
@property (nonatomic, retain)NSString *uriplayer, *uritutor, *edad, *nickname, *salida, *uriGame;
@property NSInteger codigoestado,modo;
//@property Boolean working;
- (NSError *)infantium_createPlayer;
- (NSString *)convertoURI:(NSString*)cadenaurl; //Convierte una URL en recurso URI
- (NSError *)infantium_createGame;// Crea un juego y lo almacena en la varialble juego
- (NSError *)infantium_sendData:(NSDictionary*)info; //Envía datos
- (NSError *)infantium_destroyGame;// Crea un juego y lo almacena en la varialble juego
- (void)getTutorFromPlayer:(NSString*)player; //Obtiene el tutor de un jugador específico
- (NSString *)get_gameplay_uuid; //Obtiene el gameplay uuid
- (NSString *)get_player_uuid; //Obtiene el player uuid
- (NSString *)get_contentapp_uuid; //Obtiene el contenapp uuid
- (NSDictionary*)dictionaryWithContentsOfJSONString:(NSString*)fileLocation; //utilizado para enviar json dummies de ficheros de texto
@end
