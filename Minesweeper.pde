import de.bezier.guido.*;
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>();
private int numMines = NUM_ROWS*NUM_COLS/5;
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[20][20];
    for(int i=0; i<NUM_ROWS; i++){
        for(int j=0; j<NUM_COLS; j++){
            buttons[i][j] = new MSButton(i, j);
        }
    }
    
    setMines();
}
public void setMines()
{
    for(int i=0; i<numMines; i++){
        int randomRowNum = (int)(Math.random()*5);
        System.out.println(randomRowNum);
        int randomColNum = (int)(Math.random()*5);
        System.out.println(randomColNum);
        if(!mines.contains(buttons[randomRowNum][randomColNum])){
            mines.add(buttons[randomRowNum][randomColNum]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    boolean isValid = false;
    if((r >= 0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS)){
        isValid = true;
    }
    return isValid;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    if(isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1])){
        numMines++;
    }
    if(isValid(row-1, col) && mines.contains(buttons[row-1][col])){
        numMines++;
    }
    if(isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1])){
        numMines++;
    }
    if(isValid(row, col-1) && mines.contains(buttons[row][col-1])){
        numMines++;
    }
    if(isValid(row, col+1) && mines.contains(buttons[row][col+1])){
        numMines++;
    }
    if(isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1])){
        numMines++;
    }
    if(isValid(row+1, col) && mines.contains(buttons[row+1][col])){
        numMines++;
    }
    if(isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1])){
        numMines++;
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT){
            if(flagged == true){
                flagged = false;
            }else{
                flagged = true;
            }
            if(flagged == false){
                clicked = false;
            }
        }else if(mines.contains(this)){
            displayLosingMessage();
        }else if(countMines(this.myRow, this.myCol) > 0){
            setLabel(countMines(this.myRow, this.myCol));
        }else{
            if(isValid(this.myRow-1, this.myCol-1)){
                buttons[this.myRow-1][this.myCol-1].mousePressed();
            }
            if(isValid(this.myRow-1, this.myCol)){
                buttons[this.myRow-1][this.myCol].mousePressed();
            }
            if(isValid(this.myRow-1, this.myCol+1)){
                buttons[this.myRow-1][this.myCol+1].mousePressed();
            }
            if(isValid(this.myRow, this.myCol-1)){
                buttons[this.myRow][this.myCol-1].mousePressed();            
            }
            if(isValid(this.myRow, this.myCol+1)){
                buttons[this.myRow][this.myCol+1].mousePressed();
            }
            if(isValid(this.myRow+1, this.myCol-1)){
                buttons[this.myRow+1][this.myCol-1].mousePressed();
            }
            if(isValid(this.myRow+1, this.myCol)){
                buttons[this.myRow+1][this.myCol].mousePressed();
            }
            if(isValid(this.myRow+1, this.myCol+1)){
                buttons[this.myRow+1][this.myCol+1].mousePressed();
            }
        }
    }

    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}