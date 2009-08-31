package com.collectivecolors.utils
{
  //----------------------------------------------------------------------------
  // Imports
  
  import com.collectivecolors.errors.XMLParseError;
  
  //----------------------------------------------------------------------------
  
  public class XMLParser
  {
    //--------------------------------------------------------------------------
    // Static methods
  
    /**
     * Parse a required single tag value. Duplicates are ignored.
     */
    public static function parseSingleTagRequired( result : XML,
		                                               tag : String,
		                                               notFoundError : String,
		                                               invalidError : String ) 
		                                               : String
		{
		  // Single tag required.	
		  if ( ! result.hasOwnProperty( tag ) )
			{
				throw new XMLParseError( notFoundError, tag );	
			}
			else if ( ! result[ tag ].hasSimpleContent( ) )
			{
				throw new XMLParseError( invalidError, tag );
			}
			
			return result[ tag ]; 
		}
		
		/**
		 * Parse an optional single tag value.  Duplicates are ignored.
		 */
		public static function parseSingleTagOptional( result : XML,
		                                               tag : String,
		                                               invalidError : String ) 
		                                               : String
		{
		  // Single tag optional.			
			if ( result.hasOwnProperty( tag ) )
			{
				if ( ! result[ tag ].hasSimpleContent( ) )
				{
					throw new XMLParseError( invalidError, tag );	
				}
				
				return result[ tag ];
			}
			
			return '';
		}
		
		/**
		 * Parse at least one tag value.
		 */
		public static function parseMultiTagRequired( result : XML,
		                                              tag : String,
		                                              notFoundError : String,
		                                              invalidError : String ) 
		                                              : Array
		{
		  // At least one tag required.
			if ( ! result.hasOwnProperty( tag ) )
			{
				throw new XMLParseError( notFoundError, tag );	
			}
			
			return parseMultiTag( result, tag, invalidError ); 
		}
		
		/**
		 * Parse any tag values that exist.
		 */
		public static function parseMultiTagOptional( result : XML,
		                                              tag : String,
		                                              invalidError : String ) 
		                                              : Array
		{
		  // Multiple tags optional.
		  var elements : Array = [ ];
		  
			if ( result.hasOwnProperty( tag ) )
			{
				elements = parseMultiTag( result, tag, invalidError );	
			}
			
			return elements;
		}
		
		//--------------------------------------------------------------------------
		// Private helper functions
		
		/**
		 * Parse elements of an XML section
		 */
		private static function parseMultiTag( result : XML,
		                                       tag : String,
		                                       invalidError : String ) : Array
		{
		  // Make sure all elements are simple XML elements.
			var elements : Array = [ ];
			
			for each (var data : XML in result[ tag ] )
			{
				if ( ! data.hasSimpleContent( ) )
				{
					throw new XMLParseError( invalidError, tag );	
				}
				
				elements.push( data );
			}
			
			return elements; 
		}		
  }
}