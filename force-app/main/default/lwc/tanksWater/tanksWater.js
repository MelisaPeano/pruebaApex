import { LightningElement, track } from 'lwc';
import papaparse from '@salesforce/resourceUrl/papaparse';
import { loadScript } from 'lightning/platformResourceLoader';
import createTanks from '@salesforce/apex/uploadtanks.createTanks';


export default class CargarDeTanques extends LightningElement {
    @track csvData = [];
    papaparseInitialized = false;

    columns = [
        { label: 'Nombre', fieldName: 'Name' },
        { label: 'Marca', fieldName: 'Marca__c' },
        { label: 'Capacidad', fieldName: 'Capacidad__c' },
        { label: 'Precio de Lista', fieldName: 'Precio_de_lista__c' }
    ];

    connectedCallback() {
        if (!this.papaparseInitialized) {
            loadScript(this, papaparse)
                .then(() => {
                    this.papaparseInitialized = true;
                })
                .catch(error => {
                    console.error('Error loading PapaParse', error);
                });
        }
    }

    handleFileChange(event) {
        const file = event.target.files[0];
        if (file) {
            this.parseCSV(file);
        }
    }

    parseCSV(file) {
        Papa.parse(file, {
            header: true,
            skipEmptyLines: true,
            complete: (results) => {
                this.csvData = results.data;
            }
        });
    }
    get hasCsvData() {
        return this.csvData && this.csvData.length > 0;
    }
    handleConfirm() {
       createTanks({ tanks: this.csvData })
           .then(() => {
               console.log('Tanques creados exitosamente');
               this.csvData = [];
            })
            .catch(error => {
                console.error('Error al insertar tanques', error);
          });
    }
}