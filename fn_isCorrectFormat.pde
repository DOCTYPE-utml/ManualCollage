boolean isCorrectFormat(String path,String format){
  if(path.indexOf(format)==path.length()-format.length()){
    return true;
  }else{
    return false;
  }
}
